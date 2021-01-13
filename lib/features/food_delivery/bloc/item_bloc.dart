import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/classification_listing.dart';

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

        if (event.onEditMode) isShouldBeValid = true;

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
          var isValid = [];

          var newItem = currentState.item.rebuild((item) => item
            ..additionals[event.additionalIndex] = item
                .additionals[event.additionalIndex]
                .rebuild((additional) => additional
                  ..additionalListing[event.additionalListIndex] = additional
                      .additionalListing[event.additionalListIndex]
                      .rebuild((item) => item..isSelected = event.isSelected)));

          yield currentState.copyWith(item: newItem);

          num additionalPrice = 0;

          newItem.additionals.forEach((additional) {
            int numOfSelected = 0;

            additional.additionalListing.forEach((item) {
              if (item.isSelected != null && item.isSelected == true) {
                numOfSelected += 1;
                additionalPrice += item.additionalPrice;
              }
            });

            isValid.add(numOfSelected >= additional.minMax.first);
            isValid.add(numOfSelected <= additional.minMax.last);
            return true;
          });
          print(isValid);
          newItem = newItem.rebuild(
            (item) => item
              ..isValid = !isValid.contains(false)
              ..additionalPrice = additionalPrice,
          );
          yield currentState.copyWith(
              item: newItem, additionalPrice: additionalPrice);
        } catch (e, stacktrace) {
          print('Cannot rebuild item.');
          print(e);
          log(stacktrace.toString());
        }
      }
    }
  }
}
