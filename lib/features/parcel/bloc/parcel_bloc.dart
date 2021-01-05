import 'dart:async';
import 'dart:convert';

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
            // TODO: Compute fare here
            num motorcycleFare = 0.00;
            num car2Seaterfare = 0.00;
            num car4SeaterFare = 0.00;
            num car7SeaterFare = 0.00;
            num duration = 0;
            num distance = 0;
            num weight = 0;

            currentState.points.forEach((e) => weight += e.weight);

            builtDirections.routes.first.legs.forEach((e) {
              duration += e.duration.value;
              distance += e.distance.value;
            });

            yield currentState.copyWith(directions: builtDirections, data: {
              'motorcycleFare': motorcycleFare,
              'car2Seaterfare': car2Seaterfare,
              'car4SeaterFare': car4SeaterFare,
              'car7SeaterFare': car7SeaterFare,
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
    }
  }
}
