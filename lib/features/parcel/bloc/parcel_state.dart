part of 'parcel_bloc.dart';

abstract class ParcelState extends Equatable {
  const ParcelState();

  @override
  List<Object?> get props => [];
}

class ParcelLoadingInProgress extends ParcelState {}

class ParcelLoadSuccess extends ParcelState {
  final BuiltStop? pickup;
  final BuiltList<BuiltStop>? points;
  final Map<String, dynamic>? data;
  final BuiltDirections? directions;
  final String? type;
  final num subtotal;
  final bool hasHandlingFee;

  const ParcelLoadSuccess([
    this.pickup,
    this.points,
    this.data,
    this.directions,
    this.type,
    this.subtotal = 0,
    this.hasHandlingFee = false,
  ]);

  @override
  List<Object?> get props => [pickup, points, data, directions, type, subtotal];

  @override
  String toString() => 'ParcelLoadSuccess { pickup: $pickup, points: $points }';

  ParcelLoadSuccess copyWith({
    BuiltStop? pickup,
    BuiltList<BuiltStop>? points,
    Map<String, dynamic>? data,
    BuiltDirections? directions,
    String? type,
    num? subtotal,
    bool? hasHandlingFee,
  }) =>
      ParcelLoadSuccess(
        pickup ?? this.pickup,
        points ?? this.points,
        data ?? this.data,
        directions ?? this.directions,
        type ?? this.type,
        subtotal ?? this.subtotal,
        hasHandlingFee ?? this.hasHandlingFee,
      );
}

class ParcelLoadFailure extends ParcelState {}
