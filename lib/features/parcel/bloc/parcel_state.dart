part of 'parcel_bloc.dart';

abstract class ParcelState extends Equatable {
  const ParcelState();

  @override
  List<Object> get props => [];
}

class ParcelLoadingInProgress extends ParcelState {}

class ParcelLoadSuccess extends ParcelState {
  final Stop pickup;
  final List<Stop> points;

  const ParcelLoadSuccess([this.pickup, this.points = const []]);

  @override
  List<Object> get props => [pickup, points];

  @override
  String toString() => 'ParcelLoadSuccess { pickup: $pickup, points: $points }';

  ParcelLoadSuccess copyWith({Stop pickup, List<Stop> points}) =>
      ParcelLoadSuccess(pickup ?? this.pickup, points ?? this.points);
}

class ParcelLoadFailure extends ParcelState {}
