import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../parcel/built_models/built_request.dart';

part 'food_ride_event.dart';
part 'food_ride_state.dart';

class FoodRideBloc extends Bloc<FoodRideEvent, FoodRideState> {
  final requestsCollection = FirebaseFirestore.instance.collection('requests');
  final driversRepository = FirebaseFirestore.instance.collection('drivers');
  final clientsRepository = FirebaseFirestore.instance.collection('clients');

  StreamSubscription _rideSubscription;

  FoodRideBloc() : super(FoodRideInitial());

  @override
  Stream<FoodRideState> mapEventToState(
    FoodRideEvent event,
  ) async* {
    if (event is StartListenOnFoodRide) {
      yield FoodRideLoading();
      try {
        _rideSubscription?.cancel();
        _rideSubscription =
            requestsCollection.doc(event.id).snapshots().map((snapshot) {
          return BuiltRequest.fromJson(json.encode(snapshot.data()));
        }).listen((event) {
          return add(FoodRideUpdated(event));
        });
      } catch (e) {
        print('Failed loading parcel');
        print(e);
        await FirebaseFirestore.instance
            .collection('clients')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .update({'delivery_status': 'idle'});
        yield FoodRideFailure();
      }
    } else if (event is FoodRideUpdated) {
      try {
        switch (event.ride.status) {
          case 'completed':
            this.add(AddFinishedFoodRideToUser(event.ride));
            this.add(StopListenOnFoodRide());
            break;
          case 'cancelled':
            this.add(AddFinishedFoodRideToUser(event.ride));
            this.add(StopListenOnFoodRide());
            break;
        }
        print('currently listening on ${event.ride.toString()}');
        yield FoodRideLoaded(event.ride);
      } catch (e) {
        print('Failed updating currentState ride on parcel');
        print(e);
        await FirebaseFirestore.instance
            .collection('clients')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .update({'delivery_status': 'idle'});
        yield FoodRideFailure();
      }
    } else if (event is StopListenOnFoodRide) {
      _rideSubscription?.cancel();
      yield FoodRideInitial();
    } else if (event is AddFinishedFoodRideToUser) {
      if (event.ride.status == 'completed' ||
          event.ride.status == 'cancelled') {
        try {
          await clientsRepository
              .doc(FirebaseAuth.instance.currentUser.uid)
              .update({
            'rides': FieldValue.arrayUnion([json.decode(event.ride.toJson())])
          });
          await driversRepository.doc(event.ride.driverId).update({
            'rides': FieldValue.arrayUnion([json.decode(event.ride.toJson())]),
          });
        } catch (e) {
          print('Failed updating client and driver rides.');
          print(e);
          await FirebaseFirestore.instance
              .collection('clients')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .update({'delivery_status': 'idle'});
          yield FoodRideFailure();
        }
      }
    }
  }
}
