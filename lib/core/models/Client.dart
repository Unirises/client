import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../features/parcel/built_models/built_request.dart';

class Client extends Equatable {
  const Client({
    required this.id,
    this.position,
    this.token,
    this.onRide,
    this.status,
    this.ride_id,
    this.rides,
    this.delivery_id,
    this.delivery_status,
    this.balance,
  });

  final String id;
  final dynamic position;
  final String? token;
  final bool? onRide;
  final String? status;
  final String? ride_id;
  final List<dynamic>? rides;
  final String? delivery_status;
  final String? delivery_id;
  final num? balance;

  @override
  List<Object?> get props => [
        id,
        position,
        token,
        onRide,
        status,
        ride_id,
        rides,
        delivery_status,
        delivery_id,
        balance,
      ];

  static Client fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()!;
    return Client(
      id: snapshot.id,
      position: data['position'],
      token: data['token'].toString(),
      onRide: data['onRide'] == true,
      status: data['status'] ?? 'idle',
      ride_id: data['ride_id'].toString(),
      rides: (data['rides'] != null)
          ? data['rides']
              .map((e) => BuiltRequest.fromJson(json.encode(e)))
              .toList()
          : [],
      delivery_id: data['delivery_id'] == false ? null : data['delivery_id'],
      delivery_status: data['delivery_status'],
      balance: data['balance'] != null ? data['balance'] : 0,
    );
  }
}
