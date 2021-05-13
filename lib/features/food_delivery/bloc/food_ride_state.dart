part of 'food_ride_bloc.dart';

abstract class FoodRideState extends Equatable {
  const FoodRideState();

  @override
  List<Object?> get props => [];
}

class FoodRideInitial extends FoodRideState {}

class FoodRideLoading extends FoodRideState {}

class FoodRideLoaded extends FoodRideState {
  final BuiltRequest? request;
  final BitmapDescriptor? carImage;

  FoodRideLoaded(this.request, this.carImage);

  @override
  List<Object?> get props => [request];
}

class FoodRideFailure extends FoodRideState {}
