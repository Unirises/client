import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jg_express_client/models/Merchant.dart';

abstract class UserFirestoreRepositoryAbstract {
  Future<DocumentSnapshot> getUserData();
  Future<void> updateUserCollection(Map<String, dynamic> data);
  getMerchants();
}

class UserFirestoreRepository implements UserFirestoreRepositoryAbstract {
  @override
  Future<DocumentSnapshot> getUserData() async {
    return await FirebaseFirestore.instance
        .doc('users/${FirebaseAuth.instance.currentUser.uid}')
        .get();
  }

  @override
  Future<void> updateUserCollection(Map<String, dynamic> data) async {
    return await FirebaseFirestore.instance
        .doc('users/${FirebaseAuth.instance.currentUser.uid}')
        .set(data, SetOptions(merge: true));
  }

  @override
  getMerchants() async {
    var lists = [];
    var filteredList = [];

    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('type', isEqualTo: 'merchant')
        .get();

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    for (var docs in data.docs) {
      var dataWithID = docs.data();
      dataWithID['id'] = docs.id;

      if (dataWithID['place'] != null) {
        dataWithID['distance'] = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          cast<double>(dataWithID['place']['lat']),
          cast<double>(dataWithID['place']['lng']),
        );
        lists.add(dataWithID);
      }
    }

    return lists.where((element) => element['verified_at'] != null).toList();
  }
}
