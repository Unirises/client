part of 'parcel_ride_bloc.dart';

abstract class ParcelRideEvent extends Equatable {
  const ParcelRideEvent();

  @override
  List<Object?> get props => [];
}

class StartListenOnParcelRide extends ParcelRideEvent {
  final String? id;

  StartListenOnParcelRide(this.id);
}

class StopListenOnParcelRide extends ParcelRideEvent {}

class ParcelRideUpdated extends ParcelRideEvent {
  final BuiltRequest? ride;

  ParcelRideUpdated(this.ride);

  @override
  List<Object?> get props => [ride];
}

class AddFinishedParcelRideToUser extends ParcelRideEvent {
  final BuiltRequest? ride;

  AddFinishedParcelRideToUser(this.ride);

  @override
  List<Object?> get props => [ride];
}