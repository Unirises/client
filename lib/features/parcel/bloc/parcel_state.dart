part of 'parcel_bloc.dart';

abstract class ParcelState extends Equatable {
  const ParcelState();

  @override
  List<Object> get props => [];
}

class ParcelLoadingInProgress extends ParcelState {}

class ParcelLoadSuccess extends ParcelState {
  final BuiltStop pickup;
  final BuiltList<BuiltStop> points;
  final Map<String, dynamic> data;
  final BuiltDirections directions;

  const ParcelLoadSuccess([
    this.pickup,
    this.points,
    this.data,
    this.directions,
  ]);

  @override
  List<Object> get props => [pickup, points];

  @override
  String toString() => 'ParcelLoadSuccess { pickup: $pickup, points: $points }';

  ParcelLoadSuccess copyWith({
    BuiltStop pickup,
    BuiltList<BuiltStop> points,
    Map<String, dynamic> data,
    BuiltDirections directions,
  }) =>
      ParcelLoadSuccess(pickup ?? this.pickup, points ?? this.points,
          data ?? this.data, directions ?? this.directions);
}

class ParcelLoadFailure extends ParcelState {}
