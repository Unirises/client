part of 'requests_bloc.dart';

abstract class RequestsState extends Equatable {
  const RequestsState();
}

class RequestsInitial extends RequestsState {
  @override
  List<Object> get props => [];
}

class CurrentRideLoaded extends RequestsState {
  final Request request;

  const CurrentRideLoaded(this.request);

  @override
  List<Object> get props => [request];
}
