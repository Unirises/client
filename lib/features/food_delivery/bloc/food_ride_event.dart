part of 'food_ride_bloc.dart';

abstract class FoodRideEvent extends Equatable {
  const FoodRideEvent();

  @override
  List<Object?> get props => [];
}

class StartListenOnFoodRide extends FoodRideEvent {
  final String? id;

  StartListenOnFoodRide(this.id);
}

class StopListenOnFoodRide extends FoodRideEvent {}

class FoodRideUpdated extends FoodRideEvent {
  final BuiltRequest? ride;

  FoodRideUpdated(this.ride);

  @override
  List<Object?> get props => [ride];
}

class AddFinishedFoodRideToUser extends FoodRideEvent {
  final BuiltRequest? ride;

  AddFinishedFoodRideToUser(this.ride);

  @override
  List<Object?> get props => [ride];
}
