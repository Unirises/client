part of 'parcel_bloc.dart';

abstract class ParcelEvent extends Equatable {
  const ParcelEvent();

  @override
  List<Object> get props => [];
}

class ParcelLoaded extends ParcelEvent {}

class ParcelAdded extends ParcelEvent {
  final Stop point;
  final bool isDestination;

  const ParcelAdded(this.point, this.isDestination);

  @override
  List<Object> get props => [point];

  @override
  String toString() => 'ParcelAdded { point: $point }';
}

class ParcelUpdated extends ParcelEvent {
  final Stop point;
  final bool isDestination;

  const ParcelUpdated(this.point, this.isDestination);

  @override
  List<Object> get props => [point];

  @override
  String toString() => 'ParcelUpdated { point: $point }';
}

class ParcelDeleted extends ParcelEvent {
  final Stop point;
  final bool isDestination;

  const ParcelDeleted(this.point, this.isDestination);

  @override
  List<Object> get props => [point];

  @override
  String toString() => 'ParcelDeleted { point: $point }';
}

class ComputeFare extends ParcelEvent {}
