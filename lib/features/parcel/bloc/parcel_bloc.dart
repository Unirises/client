import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client/features/parcel/built_models/built_directions.dart';
import 'package:client/features/parcel/built_models/location.dart';
import 'package:client/features/parcel/models/Stop.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'parcel_event.dart';
part 'parcel_state.dart';

class ParcelBloc extends Bloc<ParcelEvent, ParcelState> {
  ParcelBloc() : super(ParcelLoadSuccess());

  @override
  Stream<ParcelState> mapEventToState(
    ParcelEvent event,
  ) async* {
    final currentState = state;
    if (event is ParcelAdded) {
      if (currentState is ParcelLoadSuccess) {
        if (!event.isDestination) {
          final List<Stop> updatedPoints =
              List.from((state as ParcelLoadSuccess).points)..add(event.point);

          yield currentState.copyWith(points: updatedPoints);
        } else {
          final Stop updatedPickup = event.point;
          yield currentState.copyWith(pickup: updatedPickup);
        }
      }
    } else if (event is ParcelUpdated) {
      if (currentState is ParcelLoadSuccess) {
        if (!event.isDestination) {
          final List<Stop> updatedPoints =
              (state as ParcelLoadSuccess).points.map((point) {
            return point.id == event.point.id ? event.point : point;
          }).toList();
          yield currentState.copyWith(points: updatedPoints);
        } else {
          final Stop updatedPickup = event.point;
          yield currentState.copyWith(pickup: updatedPickup);
        }
      }
    } else if (event is ParcelDeleted) {
      if (currentState is ParcelLoadSuccess) {
        if (!event.isDestination) {
          final updatedPoints = (state as ParcelLoadSuccess)
              .points
              .where((point) => point.id != event.point.id)
              .toList();
          yield currentState.copyWith(points: updatedPoints);
        } else {
          yield currentState.copyWith(pickup: Stop(id: null));
        }
      }
    } else if (event is ComputeFare) {
      var data = await Dio().get(
          "https://maps.googleapis.com/maps/api/directions/json?origin=14.6894917,121.1120518&destination=14.6998849,121.1262652&waypoints=14.6481305,121.1014372&key=AIzaSyBWlDJm4CJ_PAhhrC0F3powcfmy_NJEn2E");
      BuiltDirections builtDirections = BuiltDirections.fromJson(data.data);
      print(builtDirections);
    }
  }
}
