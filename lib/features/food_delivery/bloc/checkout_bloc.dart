import 'dart:async';
import 'dart:developer';

import 'package:built_collection/built_collection.dart';
import 'package:bloc/bloc.dart';
import 'package:client/features/food_delivery/models/classification_listing.dart';
import 'package:client/features/parcel/built_models/built_directions.dart';
import 'package:client/features/parcel/built_models/built_stop.dart';
import 'package:equatable/equatable.dart';

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
        yield currentState.copyWith(pickup: event.store);
      }
    } else if (event is CheckoutDestinationUpdated) {
      if (currentState is CheckoutLoadSuccess) {
        yield currentState.copyWith(destination: event.destination);
      }
    } else if (event is ComputeFare) {
      log('COMPUTE FARE TRIGGERED');
    }
  }
}
