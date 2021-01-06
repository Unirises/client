import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:client/core/models/Request.dart';
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
      try {
        if (currentState is ParcelLoadSuccess) {
          yield ParcelLoadingInProgress();
          var data;
          if (currentState.points.length > 1) {
            print('multiple waypoints');
            var stopsCoords = [];
            var stopCoordsString = '';

            currentState.points.forEach((element) {
              stopsCoords
                  .add('${element.location.lat},${element.location.lng}');
            });

            stopsCoords.removeLast();

            stopCoordsString =
                stopsCoords.reduce((value, element) => value + '|' + element);
            print(stopCoordsString);

            data = await Dio().get(
                "https://maps.googleapis.com/maps/api/directions/json?origin=${currentState.pickup.location.lat},${currentState.pickup.location.lng}&destination=${currentState.points.last.location.lat},${currentState.points.last.location.lng}&waypoints=${stopCoordsString}&key=AIzaSyAt9lUp_riyazE0ZgeSPya-HPtiWBxkMiU");
          } else {
            print('single waypoint');
            print(currentState.pickup.location);
            print(currentState.points);
            print(currentState.points.first.location);
            data = await Dio().get(
                "https://maps.googleapis.com/maps/api/directions/json?origin=${currentState.pickup.location.lat},${currentState.pickup.location.lng}&destination=${currentState.points.first.location.lat},${currentState.points.first.location.lng}&key=AIzaSyAt9lUp_riyazE0ZgeSPya-HPtiWBxkMiU");
          }
          BuiltDirections builtDirections =
              BuiltDirections.fromJson(json.encode(data.data));

          if (builtDirections.routes.length != 1) {
            yield ParcelLoadFailure();
          } else {
            num duration = 0;
            num distance = 0;
            num weight = 0;

            currentState.points.forEach((e) => weight += e.weight);

            builtDirections.routes.first.legs.forEach((e) {
              duration += e.duration.value;
              distance += e.distance.value;
            });

            yield currentState.copyWith(directions: builtDirections, data: {
              'duration': duration,
              'distance': distance,
              'weight': weight,
            });
          }
        }
      } catch (e) {
        print(e);
        yield ParcelLoadFailure();
      }
    } else if (event is RequestParcel) {
      try {
        if (currentState is ParcelLoadSuccess) {
          yield ParcelLoadingInProgress();
          var directions = currentState.directions;
          var points = currentState.points;
          var newPoints = [];
          for (int i = 0; i < points.length; i++) {
            var item = points[i];
            newPoints.add(Stop());
          }
        }
      } catch (e) {
        print(e);
        yield ParcelLoadFailure();
      }
    }
  }
}
