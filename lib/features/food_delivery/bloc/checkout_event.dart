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
  final int index;

  CheckoutItemDeleted(this.item, this.index);

  @override
  List<Object> get props => [item, index];

  @override
  String toString() => 'CheckoutItemDeleted { item: $item, index: $index }';
}

class CheckoutStoreUpdated extends CheckoutEvent {
  final Merchant merchant;

  CheckoutStoreUpdated(this.merchant);

  @override
  List<Object> get props => [merchant];

  @override
  String toString() => 'CheckoutStoreUpdated { merchant: $merchant }';
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

class CheckoutBookRide extends CheckoutEvent {
  final String name;
  final String number;
  final FoodRideBloc foodRideBloc;
  final String storeID;

  CheckoutBookRide({this.name, this.number, this.foodRideBloc, this.storeID});

  @override
  List<Object> get props => [name, number];

  @override
  String toString() => 'CheckoutBookRide { name: $name, number: $number }';
}

class CheckoutVehicleUpdated extends CheckoutEvent {
  final String selectedVehicleType;

  CheckoutVehicleUpdated({this.selectedVehicleType});

  @override
  List<Object> get props => [selectedVehicleType];

  @override
  String toString() =>
      'CheckoutVehicleUpdated { selectedVehicleType: $selectedVehicleType }';
}
