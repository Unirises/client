part of 'pabili_delivery_bloc.dart';

abstract class PabiliDeliveryState extends Equatable {
  const PabiliDeliveryState();

  @override
  List<Object> get props => [];
}

class PabiliDeliveryInitial extends PabiliDeliveryState {}

class PabiliDeliveryLoaded extends PabiliDeliveryState {
  final Request request;
  const PabiliDeliveryLoaded(this.request);

  @override
  List<Object> get props => [request];
}
