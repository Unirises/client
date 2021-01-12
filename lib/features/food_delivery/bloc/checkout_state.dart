part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutLoadingInProgress extends CheckoutState {}

class CheckoutLoadSuccess extends CheckoutState {
  final Merchant merchant;
  final BuiltStop destination;
  final BuiltStop pickup;
  final BuiltList<ClassificationListing> items;
  final Map<String, dynamic> data;
  final BuiltDirections directions;
  final String selectedVehicleType;
  final num deliveryFee;

  const CheckoutLoadSuccess([
    this.merchant,
    this.destination,
    this.pickup,
    this.items,
    this.data,
    this.directions,
    this.selectedVehicleType,
    this.deliveryFee,
  ]);

  @override
  List<Object> get props => [
        merchant,
        destination,
        pickup,
        items,
        data,
        directions,
        selectedVehicleType,
        deliveryFee,
      ];

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
    String selectedVehicleType,
    num deliveryFee,
  }) =>
      CheckoutLoadSuccess(
        merchant ?? this.merchant,
        destination ?? this.destination,
        pickup ?? this.pickup,
        items ?? this.items,
        data ?? this.data,
        directions ?? this.directions,
        selectedVehicleType ?? this.selectedVehicleType,
        deliveryFee ?? this.deliveryFee,
      );
}

class CheckoutLoadFailure extends CheckoutState {}
