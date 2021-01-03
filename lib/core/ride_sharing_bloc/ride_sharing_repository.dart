import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Request.dart';

class RideSharingRepository {
  final requestsCollection = FirebaseFirestore.instance.collection('requests');

  Stream<Request> ride(String ride_id) {
    return requestsCollection.doc(ride_id).snapshots().map((snapshot) {
      return Request.fromSnapshot(snapshot);
    });
  }
}
