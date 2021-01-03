import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

T cast<T>(dynamic x, {T fallback}) => x is T ? x : fallback;

class Merchant extends Equatable {
  const Merchant(
      {@required this.id,
      @required this.address,
      @required this.averageTimePreparation,
      @required this.companyName,
      @required this.startTime,
      @required this.endTime,
      @required this.hero,
      @required this.place,
      @required this.representative,
      @required this.distance,
      @required this.stars})
      : assert(id != null),
        assert(address != null),
        assert(averageTimePreparation != null),
        assert(companyName != null),
        assert(startTime != null),
        assert(endTime != null),
        assert(hero != null),
        assert(place != null),
        assert(representative != null);

  final String id;
  final String address;
  final int averageTimePreparation;
  final String companyName;
  final String startTime;
  final String endTime;
  final String hero;
  final Map<String, dynamic> place;
  final Map<String, dynamic> representative;
  final double distance;
  final dynamic stars;

  static Merchant fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data();
    return Merchant(
        id: snapshot.id,
        address: data['address']?.toString(),
        averageTimePreparation: cast<int>(data['averageTimePreparation']),
        companyName: data['companyName']?.toString(),
        startTime: data['startTime']?.toString(),
        endTime: data['endTime']?.toString(),
        hero: data['hero']?.toString(),
        place: cast<Map<String, dynamic>>(data['place']),
        representative: cast<Map<String, dynamic>>(data['representative']));
  }

  static Merchant fromMap(Map<String, dynamic> data) {
    return Merchant(
      id: data['id'].toString(),
      address: data['address']?.toString(),
      averageTimePreparation: cast<int>(data['averageTimePreparation']) ?? 0,
      companyName: data['companyName']?.toString(),
      startTime: data['startTime']?.toString() ?? '8:00 AM',
      endTime: data['endTime']?.toString() ?? '8:00 PM',
      hero: data['hero']?.toString(),
      place: cast<Map<String, dynamic>>(data['place']),
      representative: cast<Map<String, dynamic>>(data['representative']),
      distance: cast<double>(data['distance']),
      stars: data['stars'] ?? 5.0,
    );
  }

  @override
  List<Object> get props => [
        address,
        averageTimePreparation,
        companyName,
        startTime,
        endTime,
        hero,
        place,
        representative
      ];
}
