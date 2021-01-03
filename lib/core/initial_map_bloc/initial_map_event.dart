part of 'initial_map_bloc.dart';

abstract class InitialMapEvent extends Equatable {
  const InitialMapEvent();
}

class FetchNearbyDrivers extends InitialMapEvent {
  const FetchNearbyDrivers();

  @override
  List<Object> get props => [];
}

class NearbyDriversUpdated extends InitialMapEvent {
  const NearbyDriversUpdated(this.drivers);

  final List<Driver> drivers;

  @override
  List<Object> get props => [drivers];
}

class StopFetchingNearbyDrivers extends InitialMapEvent {
  @override
  List<Object> get props => [];
}
