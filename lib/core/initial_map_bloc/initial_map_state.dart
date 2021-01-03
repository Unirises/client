part of 'initial_map_bloc.dart';

abstract class InitialMapState extends Equatable {
  const InitialMapState();
}

class InitialMapInitial extends InitialMapState {
  @override
  List<Object> get props => [];
}

class NearbyDriversLoaded extends InitialMapState {
  final List<Driver> drivers;
  NearbyDriversLoaded(this.drivers);

  @override
  List<Object> get props => [drivers];
}
