import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../../../core/client_bloc/client_repository.dart';
import '../../../core/helpers.dart';
import '../../parcel/built_models/built_directions.dart';
import '../../parcel/built_models/built_position.dart';
import '../../parcel/built_models/built_request.dart';
import '../../parcel/built_models/built_stop.dart';
import '../models/Merchant.dart';
import '../models/classification_listing.dart';
import 'food_ride_bloc.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final ClientRepository _clientRepository;
  CheckoutBloc({@required ClientRepository clientRepository})
      : assert(clientRepository != null),
        _clientRepository = clientRepository,
        super(CheckoutLoadSuccess());

  @override
  Stream<CheckoutState> mapEventToState(
    CheckoutEvent event,
  ) async* {
    final currentState = state;
    if (event is CheckoutItemAdded) {
      log(event.item.toString());
      if (currentState is CheckoutLoadSuccess) {
        var forNewInit = new BuiltList<ClassificationListing>([]);
        final BuiltList<ClassificationListing> updatedItems =
            (currentState.items == null)
                ? forNewInit.rebuild((b) => b.add(event.item))
                : currentState.items.rebuild((b) => b.add(event.item));
        yield currentState.copyWith(items: updatedItems);
      }
    } else if (event is CheckoutItemUpdated) {
      if (currentState is CheckoutLoadSuccess) {
        final BuiltList<ClassificationListing> updatedItems =
            currentState.items.rebuild((b) {
          b.map((item) {
            return item.itemName + item.itemPrice.toString() ==
                    event.item.itemName + item.itemPrice.toString()
                ? event.item
                : item;
          });
        });
        yield currentState.copyWith(items: updatedItems);
      }
    } else if (event is CheckoutItemDeleted) {
      if (currentState is CheckoutLoadSuccess) {
        final updatedItems = currentState.items
            .rebuild((b) => b.where((item) => item != event.item));

        yield currentState.copyWith(items: updatedItems);
      }
    } else if (event is CheckoutStoreUpdated) {
      if (currentState is CheckoutLoadSuccess) {
        if (event.merchant.place != null) {
          yield currentState.copyWith(
              merchant: event.merchant,
              pickup: BuiltStop((b) => b
                ..address = event.merchant.address
                ..houseDetails = event.merchant.address
                ..location = event.merchant.place.toBuilder()
                ..isCashOnDelivery = true
                ..name = event.merchant.companyName
                ..phone = event.merchant.phone
                ..startAddress = event.merchant.address
                ..startLocation = event.merchant.place.toBuilder()));
        } else {
          print('Only for empty merchants');
          var newItems = currentState.items.rebuild((b) => b..clear());
          yield currentState.copyWith(
              merchant: event.merchant, items: newItems);
        }
      }
    } else if (event is CheckoutDestinationUpdated) {
      if (currentState is CheckoutLoadSuccess) {
        log(event.destination.toString());
        yield currentState.copyWith(destination: event.destination);

        if (currentState.pickup != null) {
          try {
            var data = await Dio().get(
                "https://maps.googleapis.com/maps/api/directions/json?origin=${currentState.pickup.location.lat},${currentState.pickup.location.lng}&destination=${event.destination.location.lat},${event.destination.location.lng}&key=AIzaSyAt9lUp_riyazE0ZgeSPya-HPtiWBxkMiU");
            BuiltDirections builtDirections =
                BuiltDirections.fromJson(json.encode(data.data));

            if (builtDirections.routes.length != 1) {
              yield CheckoutLoadFailure();
            } else {
              num distance = 0;

              builtDirections.routes.first.legs.forEach((e) {
                distance += e.distance.value;
              });

              var updatedDestination = event.destination.rebuild((b) => b
                ..isCashOnDelivery = true
                ..distance = distance
                ..address = builtDirections.routes.first.legs.first.endAddress
                ..startLocation = builtDirections
                    .routes.first.legs.first.startLocation
                    .toBuilder()
                ..endLocation = builtDirections
                    .routes.first.legs.first.endLocation
                    .toBuilder()
                ..startAddress =
                    builtDirections.routes.first.legs.first.startAddress
                ..endAddress =
                    builtDirections.routes.first.legs.first.endAddress
                ..duration = builtDirections.routes.first.legs.first.duration
                    .toBuilder());
              log(updatedDestination.toString());
              yield currentState.copyWith(
                directions: builtDirections,
                destination: updatedDestination,
              );
            }
          } catch (e, stacktrace) {
            log(e.toString());
            log(stacktrace.toString());
            yield CheckoutLoadFailure();
          }
        }
      }
    } else if (event is CheckoutBookRide) {
      log('BOOK REQUEST TRIGGERED');
      try {
        if (currentState is CheckoutLoadSuccess) {
          yield CheckoutLoadingInProgress();
          var shittyPos = await Geolocator.getCurrentPosition();
          var goodPos = BuiltPosition.fromJson(json.encode(shittyPos.toJson()));
          var deviceToken = await FirebaseMessaging.instance.getToken();

          List<num> items = [];
          num subtotal = 0.00;

          currentState.items.forEach((item) {
            var tmp = 0;
            (item.additionalPrice != null)
                ? tmp += (item?.additionalPrice ?? 0)
                : null;
            tmp += item.itemPrice;
            tmp *= item.quantity;
            items.add(tmp);
          });

          if (items.length > 0) {
            subtotal = items.reduce((value, element) => value + element);
          }

          var request = BuiltRequest(
            (b) => b
              ..items = currentState.items.toBuilder()
              ..subtotal = subtotal
              ..fee = currentState.deliveryFee
              ..timestamp = DateTime.now().millisecondsSinceEpoch
              ..clientToken = deviceToken
              ..isParcel = false
              ..userId = FirebaseAuth.instance.currentUser.uid
              ..status = 'requesting'
              ..position = goodPos.toBuilder()
              ..currentIndex = 0
              ..pickup = currentState.pickup.toBuilder()
              ..clientName = event.name
              ..clientNumber = event.number
              ..directions = currentState.directions.toBuilder()
              ..destination = currentState.destination.toBuilder()
              ..rideType = currentState.selectedVehicleType,
          );

          var requestId = await _clientRepository.updateDeliveryStatus(
            data: 'requesting',
            request: request,
          );
          await FirebaseFirestore.instance
              .collection('requests')
              .doc(requestId)
              .update({'id': requestId});
          event.foodRideBloc.add(StartListenOnFoodRide(requestId));
          yield currentState.copyWith();
        }
      } catch (e) {
        print('TROUBLE ON REQUESTING RIDE');
        log(e.toString());
      }
    } else if (event is CheckoutVehicleUpdated) {
      if (currentState is CheckoutLoadSuccess) {
        var deliveryFee = computeFare(event.selectedVehicleType,
            currentState.destination.distance, false);
        var rebuildDestination =
            currentState.destination.rebuild((b) => b..price = deliveryFee);
        yield currentState.copyWith(
          selectedVehicleType: event.selectedVehicleType,
          deliveryFee: deliveryFee,
          destination: rebuildDestination,
        );
      }
    }
  }
}
