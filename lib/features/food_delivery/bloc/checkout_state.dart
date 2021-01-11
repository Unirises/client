part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutLoadingInProgress extends CheckoutState {}

class CheckoutLoadSuccess extends CheckoutState {
  final Merchant merchant;
  final num deliveryFee;
  final BuiltStop destination;
  final BuiltStop pickup;
  final BuiltList<ClassificationListing> items;
  final Map<String, dynamic> data;
  final BuiltDirections directions;

  const CheckoutLoadSuccess([
    this.merchant,
    this.deliveryFee,
    this.destination,
    this.pickup,
    this.items,
    this.data,
    this.directions,
  ]);

  @override
  List<Object> get props =>
      [merchant, deliveryFee, destination, pickup, items, data, directions];

  @override
  String toString() =>
      'CheckoutLoadSuccess { pickup: $pickup, points: $destination }';

  CheckoutLoadSuccess copyWith({
    Merchant merchant,
    BuiltStop destination,
    BuiltStop pickup,
    BuiltList<ClassificationListing> items,
    Map<String, dynamic> data,
    BuiltDirections directions,
  }) =>
      CheckoutLoadSuccess(
        merchant ?? this.merchant,
        deliveryFee ?? this.deliveryFee,
        destination ?? this.destination,
        pickup ?? this.pickup,
        items ?? this.items,
        data ?? this.data,
        directions ?? this.directions,
      );
}

class CheckoutLoadFailure extends CheckoutState {}
