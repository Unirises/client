import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:client/core/helpers.dart';
import 'package:client/features/food_delivery/models/Merchant.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../parcel/built_models/built_directions.dart';
import '../../parcel/built_models/built_stop.dart';
import '../models/classification_listing.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutLoadSuccess());

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
    } else if (event is ComputeFare) {
      log('COMPUTE FARE TRIGGERED');
      // TODO: Compute distance, fare, end location
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
