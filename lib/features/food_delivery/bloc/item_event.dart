part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class ItemAdded extends ItemEvent {
  final ClassificationListing item;

  ItemAdded(this.item);

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'ItemAdded { item: $item }';
}

class ItemQuantityUpdated extends ItemEvent {
  final int quantity;

  ItemQuantityUpdated(this.quantity);

  @override
  List<Object> get props => [quantity];

  @override
  String toString() => 'ItemQuantityUpdated { quantity: $quantity }';
}

class ItemAdditionalUpdated extends ItemEvent {}
