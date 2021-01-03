part of 'ride_sharing_bloc.dart';

abstract class RideSharingEvent extends Equatable {
  const RideSharingEvent();
}

class StartListenOnRide extends RideSharingEvent {
  final String ride_id;

  StartListenOnRide(this.ride_id);

  @override
  List<Object> get props => [ride_id];
}

class StopListeningOnRide extends RideSharingEvent {
  const StopListeningOnRide();

  @override
  List<Object> get props => [];
}

class RideUpdated extends RideSharingEvent {
  final Request ride;

  RideUpdated(this.ride);

  @override
  List<Object> get props => [ride];
}
