part of 'parcel_ride_bloc.dart';

abstract class ParcelRideState extends Equatable {
  const ParcelRideState();

  @override
  List<Object?> get props => [];
}

class ParcelRideInitial extends ParcelRideState {}

class ParcelRideLoaded extends ParcelRideState {
  final BuiltRequest? request;
  final BitmapDescriptor? carImage;

  ParcelRideLoaded(this.request, this.carImage);

  @override
  List<Object?> get props => [request];
}

class ParcelRideFailure extends ParcelRideState {}
