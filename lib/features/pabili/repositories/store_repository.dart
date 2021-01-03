import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Store.dart';

class StoreRepository {
  final merchantCollection = FirebaseFirestore.instance.collection('merchants');

  Future<List<Store>> getStores() async {
    return (await merchantCollection.get())
        .docs
        .map((e) => Store.fromSnapshot(e))
        .toList();
  }
}
