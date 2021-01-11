import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:client/features/food_delivery/models/Merchant.dart';
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
            return item == event.item ? event.item : item;
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
        yield currentState.copyWith(destination: event.destination);
        if (currentState.pickup != null) {
          // TODO: Compute fare here
          log('should compute fare');
        }
      }
    } else if (event is ComputeFare) {
      log('COMPUTE FARE TRIGGERED');
      // TODO: Compute distance, fare, end location
    }
  }
}
