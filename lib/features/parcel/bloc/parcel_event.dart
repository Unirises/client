part of 'parcel_bloc.dart';

abstract class ParcelEvent extends Equatable {
  const ParcelEvent();

  @override
  List<Object?> get props => [];
}

class ParcelLoaded extends ParcelEvent {}

class ParcelAdded extends ParcelEvent {
  final BuiltStop point;
  final bool isDestination;

  const ParcelAdded(this.point, this.isDestination);

  @override
  List<Object> get props => [point];

  @override
  String toString() => 'ParcelAdded { point: $point }';
}

class ParcelUpdated extends ParcelEvent {
  final BuiltStop point;
  final bool isDestination;

  const ParcelUpdated(this.point, this.isDestination);

  @override
  List<Object> get props => [point];

  @override
  String toString() => 'ParcelUpdated { point: $point }';
}

class ParcelDeleted extends ParcelEvent {
  final BuiltStop? point;
  final bool isDestination;

  const ParcelDeleted(this.point, this.isDestination);

  @override
  List<Object?> get props => [point];

  @override
  String toString() => 'ParcelDeleted { point: $point }';
}

class ComputeFare extends ParcelEvent {}

class RequestParcel extends ParcelEvent {
  final String? name;
  final String? number;
  final ParcelRideBloc rideBloc;

  const RequestParcel({
    required this.name,
    required this.number,
    required this.rideBloc,
  });

  @override
  List<Object?> get props => [name, number, rideBloc];

  @override
  String toString() => 'ParcelRequested';
}

class TypeUpdated extends ParcelEvent {
  final String? type;

  TypeUpdated(this.type);

  @override
  List<Object?> get props => [type];

  @override
  String toString() => 'TypeUpdated';
}

class HandlingFeeUpdated extends ParcelEvent {
  final bool value;

  HandlingFeeUpdated(this.value);
}
