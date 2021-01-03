import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/models/PlaceLocation.dart';
import 'Categories.dart';

class Store extends Equatable {
  final String id;
  final PlaceLocation location;
  final String endTime;
  final String startTime;
  final List<Categories> categories;
  final String logo;

  const Store({
    @required this.id,
    this.endTime,
    this.startTime,
    @required this.location,
    this.categories,
    this.logo,
  });

  static Store fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data();
    return Store(
      id: snapshot.id,
      endTime: data['endTime'],
      startTime: data['startTime'],
      location: PlaceLocation(
          address: data['address'],
          place: data['storeName'],
          latitude: data['place']['lat'],
          longitude: data['place']['lng']),
      categories: (data['listing']) != null
          ? Categories.fromListing(data['listing'])
          : [],
      logo: data['logo'],
    );
  }

  @override
  List<Object> get props => [endTime, startTime, location, categories];
}
