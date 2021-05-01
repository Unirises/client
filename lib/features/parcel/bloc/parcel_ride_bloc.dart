import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../built_models/built_request.dart';

part 'parcel_ride_event.dart';
part 'parcel_ride_state.dart';

class ParcelRideBloc extends Bloc<ParcelRideEvent, ParcelRideState> {
  final requestsCollection = FirebaseFirestore.instance.collection('requests');
  final driversRepository = FirebaseFirestore.instance.collection('drivers');
  final clientsRepository = FirebaseFirestore.instance.collection('clients');

  StreamSubscription? _rideSubscription;

  ParcelRideBloc() : super(ParcelRideInitial());

  @override
  Stream<ParcelRideState> mapEventToState(
    ParcelRideEvent event,
  ) async* {
    if (event is StartListenOnParcelRide) {
      try {
        _rideSubscription?.cancel();
        _rideSubscription =
            requestsCollection.doc(event.id).snapshots().map((snapshot) {
          return BuiltRequest.fromJson(json.encode(snapshot.data()));
        }).listen((event) {
          return add(ParcelRideUpdated(event));
        });
      } catch (e) {
        print('Failed loading parcel');
        print(e);
        await FirebaseFirestore.instance
            .collection('clients')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'status': 'idle'});
        yield ParcelRideFailure();
      }
    } else if (event is ParcelRideUpdated) {
      try {
        switch (event.ride!.status) {
          case 'completed':
            this.add(AddFinishedParcelRideToUser(event.ride));
            this.add(StopListenOnParcelRide());
            break;
          case 'cancelled':
            this.add(AddFinishedParcelRideToUser(event.ride));
            this.add(StopListenOnParcelRide());
            break;
        }
        print('currently listening on ${event.ride.toString()}');
        yield ParcelRideLoaded(event.ride);
      } catch (e) {
        print('Failed updating currentState ride on parcel');
        print(e);
        await FirebaseFirestore.instance
            .collection('clients')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'status': 'idle'});
        yield ParcelRideFailure();
      }
    } else if (event is StopListenOnParcelRide) {
      _rideSubscription?.cancel();
      yield ParcelRideInitial();
    } else if (event is AddFinishedParcelRideToUser) {
      if (event.ride!.status == 'completed' ||
          event.ride!.status == 'cancelled') {
        try {
          await clientsRepository
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            'rides': FieldValue.arrayUnion([json.decode(event.ride!.toJson())])
          });
          await driversRepository.doc(event.ride!.driverId).update({
            'rides': FieldValue.arrayUnion([json.decode(event.ride!.toJson())]),
          });
        } catch (e) {
          print('Failed updating client and driver rides.');
          print(e);
          await FirebaseFirestore.instance
              .collection('clients')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'status': 'idle'});
          yield ParcelRideFailure();
        }
      }
    }
  }
}
