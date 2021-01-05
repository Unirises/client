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
  final Map<String, dynamic> data;
  final BuiltDirections directions;

  const ParcelLoadSuccess([
    this.pickup,
    this.points = const [],
    this.data,
    this.directions,
  ]);

  @override
  List<Object> get props => [pickup, points];

  @override
  String toString() => 'ParcelLoadSuccess { pickup: $pickup, points: $points }';

  ParcelLoadSuccess copyWith({
    Stop pickup,
    List<Stop> points,
    Map<String, dynamic> data,
    BuiltDirections directions,
  }) =>
      ParcelLoadSuccess(
        pickup ?? this.pickup,
        points ?? this.points,
        data ?? this.data,
        directions ?? this.directions
      );
}

class ParcelLoadFailure extends ParcelState {}
