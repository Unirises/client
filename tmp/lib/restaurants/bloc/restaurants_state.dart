part of 'restaurants_bloc.dart';

abstract class RestaurantsState extends Equatable {
  const RestaurantsState();
}

class RestaurantsInitial extends RestaurantsState {
  @override
  List<Object> get props => [];
}

class RestaurantsLoaded extends RestaurantsState {
  RestaurantsLoaded(this.restaurants);

  final List<Merchant> restaurants;

  @override
  List<Object> get props => [restaurants];
}
