part of 'pabili_delivery_bloc.dart';

abstract class PabiliDeliveryEvent extends Equatable {
  const PabiliDeliveryEvent();

  @override
  List<Object> get props => [];
}

class StartListenOnPabiliRide extends PabiliDeliveryEvent {
  final String ride_id;

  StartListenOnPabiliRide(this.ride_id);

  @override
  List<Object> get props => [ride_id];
}

class StopListenOnPabiliRide extends PabiliDeliveryEvent {
  const StopListenOnPabiliRide();

  @override
  List<Object> get props => [];
}

class RideUpdated extends PabiliDeliveryEvent {
  final Request ride;

  RideUpdated(this.ride);

  @override
  List<Object> get props => [ride];
}

class AddFinishedRideToUser extends PabiliDeliveryEvent {
  final Request request;
  const AddFinishedRideToUser(this.request);

  @override
  List<Object> get props => [request];
}

class ResetYield extends Equatable {
  const ResetYield();

  @override
  List<Object> get props => [];
}
