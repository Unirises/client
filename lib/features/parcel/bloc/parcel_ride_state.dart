part of 'parcel_ride_bloc.dart';

abstract class ParcelRideState extends Equatable {
  const ParcelRideState();

  @override
  List<Object> get props => [];
}

class ParcelRideInitial extends ParcelRideState {}

class ParcelRideLoaded extends ParcelRideState {
  final BuiltRequest request;

  ParcelRideLoaded(this.request);

  @override
  List<Object> get props => [request];
}

class ParcelRideFailure extends ParcelRideState {}
