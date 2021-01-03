import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/Request.dart';

class PabiliDeliveryRepository {
  final requestsCollection = FirebaseFirestore.instance.collection('requests');
  final driversRepository = FirebaseFirestore.instance.collection('drivers');
  final clientsRepository = FirebaseFirestore.instance.collection('clients');

  Stream<Request> order(String ride_id) {
    return requestsCollection.doc(ride_id).snapshots().map((snapshot) {
      return Request.fromSnapshot(snapshot);
    });
  }

  Future<void> addFinishedRideToData(Request rideData) {
    return driversRepository.doc(FirebaseAuth.instance.currentUser.uid).update({
      'rides': FieldValue.arrayUnion([rideData.toMap()]),
    });
  }

  Future<void> addFinishedRideToClientData(Request rideData) {
    return clientsRepository.doc(rideData.userId).update({
      'rides': FieldValue.arrayUnion([rideData.toMap()]),
    });
  }

  Future<void> deleteRequest(String id) async {
    return await requestsCollection.doc(id).delete();
  }
}
