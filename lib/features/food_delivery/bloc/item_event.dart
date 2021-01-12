part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class ItemAdded extends ItemEvent {
  final ClassificationListing item;
  final bool onEditMode;

  ItemAdded(this.item, this.onEditMode);

  @override
  List<Object> get props => [item, onEditMode];

  @override
  String toString() => 'ItemAdded { item: $item, onEditMode: $onEditMode }';
}

class ItemQuantityUpdated extends ItemEvent {
  final int quantity;

  ItemQuantityUpdated(this.quantity);

  @override
  List<Object> get props => [quantity];

  @override
  String toString() => 'ItemQuantityUpdated { quantity: $quantity }';
}

class ItemAdditionalUpdated extends ItemEvent {
  final int classificationIndex;
  final int itemIndex;
  final int additionalIndex;
  final int additionalListIndex;
  final bool isSelected;

  const ItemAdditionalUpdated(this.classificationIndex, this.itemIndex,
      this.additionalIndex, this.additionalListIndex, this.isSelected);

  @override
  List<Object> get props => [
        classificationIndex,
        itemIndex,
        additionalIndex,
        additionalListIndex,
        isSelected,
      ];

  @override
  String toString() =>
      'ItemAdditionalUpdated { 1: $classificationIndex, 2: $itemIndex, 3: $additionalIndex, 4: $additionalListIndex, isSelected: $isSelected }';
}

class ItemValidityUpdated extends ItemEvent {
  final bool isValid;

  const ItemValidityUpdated(this.isValid);

  @override
  List<Object> get props => [isValid];

  @override
  String toString() => 'ItemValidityUpdated { isValid: $isValid }';
}
