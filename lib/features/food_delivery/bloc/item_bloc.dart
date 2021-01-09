import 'dart:async';
import 'dart:developer';

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
    } else if (event is ItemAdditionalUpdated) {
      yield ItemLoadingInProgress();
      if (currentState is ItemLoaded) {
        try {
          var isNowValid = false;

          var newItem = currentState.item.rebuild((item) => item
            ..additionals[event.additionalIndex] = item
                .additionals[event.additionalIndex]
                .rebuild((additional) => additional
                  ..additionalListing[event.additionalListIndex] = additional
                      .additionalListing[event.additionalListIndex]
                      .rebuild((item) => item..isSelected = event.isSelected)));

          yield currentState.copyWith(item: newItem);

          newItem.additionals.forEach((additional) {
            int numOfSelected = 0;

            additional.additionalListing.forEach((item) {
              if (item.isSelected != null && item.isSelected == true) {
                numOfSelected += 1;
              }
            });

            print(
                'Num of selected: $numOfSelected | Min: ${additional.minMax.first} | Max: ${additional.minMax.last}');

            if (additional.type == 'radio') return isNowValid = true;

            return isNowValid = (numOfSelected >= additional.minMax.first &&
                numOfSelected <= additional.minMax.last);
          });
          print('Final validity check: ${isNowValid}');
          newItem = newItem.rebuild((item) => item..isValid = isNowValid);
          yield currentState.copyWith(item: newItem);
        } catch (e, stacktrace) {
          print('Cannot rebuild item.');
          print(e);
          log(stacktrace.toString());
        }
      }
    }
  }
}
