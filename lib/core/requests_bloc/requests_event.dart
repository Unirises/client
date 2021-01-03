part of 'requests_bloc.dart';

abstract class RequestsEvent extends Equatable {
  const RequestsEvent();
}

class StartListenOnCurrentRide extends RequestsEvent {
  final String rideId;

  const StartListenOnCurrentRide(this.rideId);

  @override
  List<Object> get props => [rideId];
}

class StopListenOnCurrentRide extends RequestsEvent {
  const StopListenOnCurrentRide();

  @override
  List<Object> get props => [];
}

class AddFinishedRideToUser extends RequestsEvent {
  final Request request;
  const AddFinishedRideToUser(this.request);

  @override
  List<Object> get props => [request];
}

class CurrentRideUpdated extends RequestsEvent {
  final Request request;
  const CurrentRideUpdated(this.request);

  @override
  List<Object> get props => [request];
}
