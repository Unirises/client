import 'dart:async';
import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:bloc/bloc.dart';
import 'package:client/core/client_bloc/client_repository.dart';
import 'package:client/core/helpers.dart';
import 'package:client/core/models/Request.dart';
import 'package:client/features/parcel/bloc/parcel_ride_bloc.dart';
import 'package:client/features/parcel/built_models/built_directions.dart';
import 'package:client/features/parcel/built_models/built_position.dart';
import 'package:client/features/parcel/built_models/built_request.dart';
import 'package:client/features/parcel/built_models/built_stop.dart';
import 'package:client/features/parcel/built_models/location.dart';
import 'package:client/features/parcel/models/Stop.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'parcel_event.dart';
part 'parcel_state.dart';

class ParcelBloc extends Bloc<ParcelEvent, ParcelState> {
  final ClientRepository _clientRepository;
  ParcelBloc({@required ClientRepository clientRepository})
      : assert(clientRepository != null),
        _clientRepository = clientRepository,
        super(ParcelLoadSuccess());

  @override
  Stream<ParcelState> mapEventToState(
    ParcelEvent event,
  ) async* {
    final currentState = state;
    if (event is ParcelAdded) {
      if (currentState is ParcelLoadSuccess) {
        if (!event.isDestination) {
          var forNewInit = new BuiltList<BuiltStop>([]);

          final BuiltList<BuiltStop> updatedPoints =
              (currentState.points == null)
                  ? forNewInit.rebuild((b) => b.add(event.point))
                  : currentState.points.rebuild((b) => b.add(event.point));
          yield currentState.copyWith(points: updatedPoints);
        } else {
          final BuiltStop updatedPickup = event.point;
          yield currentState.copyWith(pickup: updatedPickup);
        }
      }
    } else if (event is ParcelUpdated) {
      if (currentState is ParcelLoadSuccess) {
        if (!event.isDestination) {
          final BuiltList<BuiltStop> updatedPoints =
              currentState.points.rebuild((b) {
            b.map((point) {
              return point.id == event.point.id ? event.point : point;
            });
          });
          yield currentState.copyWith(points: updatedPoints);
        } else {
          final BuiltStop updatedPickup = event.point;
          yield currentState.copyWith(pickup: updatedPickup);
        }
      }
    } else if (event is ParcelDeleted) {
      if (currentState is ParcelLoadSuccess) {
        if (!event.isDestination) {
          final updatedPoints = (state as ParcelLoadSuccess)
              .points
              .rebuild((b) => b.where((point) => point.id != event.point.id));
          // .where((point) => point.id != event.point.id)
          // .toList();
          yield currentState.copyWith(points: updatedPoints);
        } else {
          yield currentState.copyWith(pickup: BuiltStop((b) => b..id = null));
        }
      }
    } else if (event is ComputeFare) {
      try {
        print('compute fare triggered');
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
          BuiltList<BuiltStop> mutatedPoints = new BuiltList<BuiltStop>([]);
          print('request triggered');
          for (int i = 0; i < points.length; i++) {
            mutatedPoints = mutatedPoints.rebuild((b) => b.add(points[i]
                .rebuild((b) => b
                  ..distance = directions.routes.first.legs[i].distance.value
                  ..duration =
                      directions.routes.first.legs[i].duration.toBuilder()
                  ..price = computeFare(event.type,
                      directions.routes.first.legs[i].distance.value, i > 1)
                  ..startLocation =
                      directions.routes.first.legs[i].startLocation.toBuilder()
                  ..endLocation =
                      directions.routes.first.legs[i].endLocation.toBuilder()
                  ..startAddress = directions.routes.first.legs[i].startAddress
                  ..endAddress = directions.routes.first.legs[i].endAddress)));
          }
          var shittyPos = await Geolocator.getCurrentPosition();
          var goodPos = BuiltPosition.fromJson(json.encode(shittyPos.toJson()));
          var deviceToken = await FirebaseMessaging.instance.getToken();

          var request = BuiltRequest((b) => b
            ..clientToken = deviceToken
            ..isParcel = true
            ..userId = FirebaseAuth.instance.currentUser.uid
            ..status = 'requesting'
            ..position = goodPos.toBuilder()
            ..currentIndex = 0
            ..points = mutatedPoints.toBuilder()
            ..pickup = currentState.pickup.toBuilder()
            ..clientName = event.name
            ..clientNumber = event.number
            ..directions = currentState.directions.toBuilder()
            ..rideType = event.type);

          var requestId = await _clientRepository.updateStatus(
            data: 'requesting',
            request: request,
          );

          event.rideBloc.add(StartListenOnParcelRide(requestId));
          yield currentState.copyWith(points: mutatedPoints);
        }
      } catch (e) {
        print(e);
        yield ParcelLoadFailure();
      }
    }
  }
}
