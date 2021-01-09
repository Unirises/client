part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class CheckoutLoaded extends CheckoutEvent {}

class CheckoutItemAdded extends CheckoutEvent {
  final ClassificationListing item;

  CheckoutItemAdded(this.item);

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'CheckoutItemAdded { item: $item }';
}

class CheckoutItemUpdated extends CheckoutEvent {
  final ClassificationListing item;

  CheckoutItemUpdated(this.item);

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'CheckoutItemUpdated { item: $item }';
}

class CheckoutItemDeleted extends CheckoutEvent {
  final ClassificationListing item;

  CheckoutItemDeleted(this.item);

  @override
  List<Object> get props => [item];

  @override
  String toString() => 'CheckoutItemDeleted { item: $item }';
}

class CheckoutStoreUpdated extends CheckoutEvent {
  final BuiltStop store;

  CheckoutStoreUpdated(this.store);

  @override
  List<Object> get props => [store];

  @override
  String toString() => 'CheckoutStoreUpdated { store: $store }';
}

class CheckoutDestinationUpdated extends CheckoutEvent {
  final BuiltStop destination;

  CheckoutDestinationUpdated(this.destination);

  @override
  List<Object> get props => [destination];

  @override
  String toString() =>
      'CheckoutDestinationUpdated { destination: $destination }';
}

class ComputeFare extends CheckoutEvent {}
