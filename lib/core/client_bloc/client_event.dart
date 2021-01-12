part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();
}

class FetchClient extends ClientEvent {
  const FetchClient();

  @override
  List<Object> get props => [];
}

class ClientUpdated extends ClientEvent {
  const ClientUpdated(this.client);

  final Client client;

  @override
  List<Object> get props => [client];
}

class StartLocationUpdate extends ClientEvent {
  const StartLocationUpdate();

  @override
  List<Object> get props => [];
}

class StopLocationUpdate extends ClientEvent {
  const StopLocationUpdate();

  @override
  List<Object> get props => [];
}

class ClientRequestsRide extends ClientEvent {
  final Request request;
  final Bloc rideSharingBloc;
  const ClientRequestsRide(this.request, this.rideSharingBloc);

  @override
  List<Object> get props => [request, rideSharingBloc];
}

class ClientRequestFood extends ClientEvent {
  final Request request;
  final Bloc pabiliDeliveryBloc;

  const ClientRequestFood(this.request, this.pabiliDeliveryBloc);

  @override
  List<Object> get props => [request, pabiliDeliveryBloc];
}

class ClientCancelRide extends ClientEvent {
  final String requestID;
  const ClientCancelRide(this.requestID);

  @override
  List<Object> get props => [requestID];
}

class ClientCancelFoodRide extends ClientEvent {
  final String requestID;
  const ClientCancelFoodRide(this.requestID);

  @override
  List<Object> get props => [requestID];
}
