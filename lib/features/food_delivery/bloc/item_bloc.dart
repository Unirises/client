import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client/features/food_delivery/models/classification_listing.dart';
import 'package:equatable/equatable.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemLoaded());

  @override
  Stream<ItemState> mapEventToState(
    ItemEvent event,
  ) async* {
    final currentState = state;
    if (event is ItemAdded) {
      if (currentState is ItemLoaded) {
        yield ItemLoadingInProgress();
        bool isShouldBeValid = true;
        event.item.additionals.forEach((additional) {
          print(additional.minMax);
          print(additional.minMax.first);
          if (additional.minMax.first >= 1) {
            isShouldBeValid = false;
          }
        });
        var newItem = event.item.rebuild((b) => b
          ..isValid = isShouldBeValid
          ..quantity = 1);
        yield currentState.copyWith(item: newItem);
      }
    } else if (event is ItemQuantityUpdated) {
      yield ItemLoadingInProgress();
      if (currentState is ItemLoaded) {
        if (event.quantity > 0) {
          var newItem =
              currentState.item.rebuild((b) => b..quantity = event.quantity);
          yield currentState.copyWith(item: newItem);
        } else {
          var newItem = currentState.item.rebuild((b) => b..quantity = 1);
          yield currentState.copyWith(item: newItem);
        }
      }
    }
  }
}
