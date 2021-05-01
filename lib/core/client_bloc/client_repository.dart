import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

import '../../features/parcel/built_models/built_request.dart';
import '../models/Client.dart';
import '../models/Driver.dart';

class ClientRepository {
  final clientCollection = FirebaseFirestore.instance.collection('clients');
  final requestsCollection = FirebaseFirestore.instance.collection('requests');
  final driversCollection = FirebaseFirestore.instance.collection('drivers');

  Stream<Client> client() {
    return clientCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      return Client.fromSnapshot(snapshot);
    });
  }

  Future<void> updatePosition(Position data) async {
    return clientCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'position': FixedPos.fromPosition(data).toJson()});
  }

  Future<void> updateToken(String? data) async {
    try {
      return clientCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'token': data,
      });
    } catch (e) {
      print('ERROR ACQUIRING TOKEN ------------');
      print(data);
      print(e);
    }
  }

  Future updateStatus({
    required String data,
    BuiltRequest? request,
    String? requestID,
  }) async {
    await clientCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'status': data});

    if (data == 'requesting' && request != null) {
      var requestResponse =
          await requestsCollection.add(json.decode(request.toJson()));
      await clientCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'ride_id': requestResponse.id});
      return requestResponse.id;
    }

    if (data == 'idle' && requestID != null) {
      await requestsCollection
          .doc(requestID)
          .set({'status': 'cancelled'}, SetOptions(merge: true));
    }

    return;
  }

  Future updateDeliveryStatus({
    required String data,
    BuiltRequest? request,
    String? requestID,
  }) async {
    await clientCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'delivery_status': data});

    if (data == 'requesting' && request != null) {
      var requestResponse =
          await requestsCollection.add(json.decode(request.toJson()));
      await clientCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'delivery_id': requestResponse.id});
      return requestResponse.id;
    }

    if (data == 'idle' && requestID != null) {
      await requestsCollection.doc(requestID).update({'status': 'cancelled'});
    }

    return;
  }

  Stream<List<Driver>> drivers() {
    return driversCollection.where('onRide', isEqualTo: false).snapshots().map(
          (event) => event.docs.map((snapshot) {
            return Driver.fromSnapshot(snapshot);
          }).toList(),
        );
  }
}

class FixedPos {
  final num? heading;
  final num? latitude;
  final num? longitude;
  final num? timestamp;

  const FixedPos({
    required this.heading,
    required this.latitude,
    required this.longitude,
    this.timestamp,
  });

  static FixedPos fromPosition(Position data) {
    return FixedPos(
      heading: data.heading,
      latitude: data.latitude,
      longitude: data.longitude,
      timestamp: data.timestamp!.millisecondsSinceEpoch,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'heading': heading,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
    };
  }

  static FixedPos fromMap(Map<String, dynamic> data) {
    return FixedPos(
      heading: data['heading'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      timestamp: data['timestamp'],
    );
  }
}
