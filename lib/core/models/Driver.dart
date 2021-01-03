import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'Request.dart';

class Driver extends Equatable {
  const Driver({
    @required this.id,
    this.ride_type,
    this.vehicle_brand,
    this.vehicle_color,
    this.vehicle_model,
    this.plate,
    this.verified_at,
    this.sent_documents,
    this.denied,
    this.position,
    this.token,
    this.onRide,
    this.ride_id,
    this.rides,
  }) : assert(id != null);

  final String id;
  final String ride_type;
  final String vehicle_brand;
  final String vehicle_color;
  final String vehicle_model;
  final String plate;
  final dynamic verified_at;
  final bool sent_documents;
  final dynamic denied;
  final dynamic position;
  final String token;
  final bool onRide;
  final String ride_id;
  final List<dynamic> rides;

  @override
  List<Object> get props => [
        id,
        ride_type,
        vehicle_brand,
        vehicle_color,
        vehicle_model,
        plate,
        verified_at,
        sent_documents,
        denied,
        position,
        token,
        onRide,
        ride_id,
        rides,
      ];

  static Driver fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data();
    return Driver(
      id: snapshot.id,
      ride_type: data['ride_type'],
      vehicle_brand: data['vehicle_brand'],
      vehicle_color: data['vehicle_color'],
      vehicle_model: data['vehicle_model'],
      plate: data['plate'],
      verified_at: data['verified_at'],
      sent_documents: data['sent_documents'],
      denied: data['denied'],
      position: data['position'],
      token: data['token'].toString(),
      onRide: data['onRide'] == true,
      ride_id: data['ride_id'].toString(),
      rides: data['rides'].map((e) => Request.fromMap(e)).toList(),
    );
  }
}
