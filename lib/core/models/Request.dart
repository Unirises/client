import 'package:client/features/parcel/models/Stop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import 'PlaceLocation.dart';

class RequestData extends Equatable {
  final String driverId;
  final String userId;
  final String status;
  final FixedPos position;
  final String driverName;
  final String driverNumber;
  final String clientName;
  final String clientNumber;
  final String rideType;
  final bool isParcel;
  final Map<String, dynamic> vehicleData;
  final String driverToken;
  final String clientToken;

  final int currentIndex;
  final Stop pickup;
  final List<dynamic> points;

  RequestData(
      this.driverId,
      this.userId,
      this.status,
      this.position,
      this.driverName,
      this.driverNumber,
      this.clientName,
      this.clientNumber,
      this.rideType,
      this.isParcel,
      this.vehicleData,
      this.driverToken,
      this.clientToken,
      this.currentIndex,
      this.pickup,
      this.points);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Request extends Equatable {
  const Request({
    this.id,
    this.driverId,
    @required this.userId,
    @required this.status,
    @required this.pickup,
    @required this.destination,
    this.position,
    @required this.distance,
    @required this.price,
    this.driverName,
    this.driverNumber,
    @required this.clientName,
    @required this.clientNumber,
    @required this.ride_type,
    @required this.isParcel,
    @required this.timestamp,
    @required this.bounds,
    @required this.encodedPolyline,
    @required this.duration,
    this.data,
    this.driverPhoto,
    this.isFoodDelivery,
    this.isChargePaid,
    this.vehicle_data,
    @required this.isPaidWithCash,
    this.driverToken,
    this.clientToken,
  });

  final String id;
  final String driverId;
  final String userId;
  final String status; // requesting, arriving, transit, cancelled, completed
  final PlaceLocation pickup;
  final PlaceLocation destination;
  final FixedPos position;
  final num distance;
  final num price;
  final String driverName;
  final String driverNumber;
  final String clientName;
  final String clientNumber;
  final String ride_type;
  final bool isParcel;
  final num timestamp;
  final Map<String, dynamic> bounds;
  final String encodedPolyline;
  final num duration;
  final dynamic data;
  final String driverPhoto;
  final bool isFoodDelivery;
  final String isChargePaid; // For Drivers only
  final dynamic vehicle_data;
  final bool isPaidWithCash;
  final String driverToken;
  final String clientToken;

  static Request fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    return Request(
      id: snapshot.id,
      driverId: data['driverId'],
      userId: data['userId'],
      status: data['status'],
      pickup: PlaceLocation.fromMap(data['pickup']),
      destination: PlaceLocation.fromMap(data['destination']),
      position: FixedPos.fromMap(data['position']),
      distance: data['distance'],
      price: (data['price'] as num),
      driverName: data['driverName'],
      driverNumber: data['driverNumber'],
      clientName: data['clientName'],
      clientNumber: data['clientNumber'],
      ride_type: data['ride_type'],
      isParcel: data['isParcel'] == true,
      timestamp: (data['timestamp'] as num),
      bounds: data['bounds'],
      encodedPolyline: data['encodedPolyline'],
      duration: data['duration'],
      data: data['data'],
      driverPhoto: data['driverPhoto'],
      isFoodDelivery: data['isFoodDelivery'],
      isChargePaid: data['isChargePaid'].toString(),
      vehicle_data: data['vehicle_data'] ?? {},
      isPaidWithCash: data['isPaidWithCash'] == true,
      driverToken: data['driverToken'],
      clientToken: data['clientToken'],
    );
  }

  static Request fromMap(Map<String, dynamic> data) {
    return Request(
      id: data['id'],
      driverId: data['driverId'],
      userId: data['userId'],
      status: data['status'],
      pickup: PlaceLocation.fromMap(data['pickup']),
      destination: PlaceLocation.fromMap(data['destination']),
      position: FixedPos.fromMap(data['position']),
      distance: data['distance'],
      price: (data['price'] as num),
      driverName: data['driverName'],
      driverNumber: data['driverNumber'],
      clientName: data['clientName'],
      clientNumber: data['clientNumber'],
      ride_type: data['ride_type'],
      isParcel: data['isParcel'] == true,
      timestamp: (data['timestamp'] as num),
      bounds: data['bounds'],
      encodedPolyline: data['encodedPolyline'],
      duration: data['duration'],
      data: data['data'],
      driverPhoto: data['driverPhoto'],
      isFoodDelivery: data['isFoodDelivery'],
      isChargePaid: data['isChargePaid'].toString(),
      vehicle_data: data['vehicle_data'] ?? {},
      isPaidWithCash: data['isPaidWithCash'] == true,
      clientToken: data['clientToken'],
      driverToken: data['driverToken'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'driverId': driverId,
      'userId': userId,
      'status': status,
      'pickup': pickup.toMap(),
      'destination': destination.toMap(),
      'position': position?.toJson() ?? {},
      'distance': distance,
      'price': price,
      'driverName': driverName,
      'driverNumber': driverNumber,
      'clientName': clientName,
      'clientNumber': clientNumber,
      'ride_type': ride_type,
      'isParcel': isParcel,
      'timestamp': timestamp,
      'bounds': bounds,
      'encodedPolyline': encodedPolyline,
      'duration': duration,
      'data': data,
      'driverPhoto': driverPhoto,
      'isFoodDelivery': isFoodDelivery,
      'isChargePaid': isChargePaid,
      'vehicle_data': vehicle_data,
      'isPaidWithCash': isPaidWithCash,
      'clientToken': clientToken,
      'driverToken': driverToken,
    };
  }

  @override
  List<Object> get props => [
        id,
        driverId,
        userId,
        status,
        pickup,
        destination,
        position,
        distance,
        price,
        driverName,
        driverNumber,
        clientName,
        clientNumber,
        ride_type,
        isParcel,
        timestamp,
        bounds,
        encodedPolyline,
        duration,
        data,
        driverPhoto,
        isFoodDelivery,
        isChargePaid,
        vehicle_data,
        isPaidWithCash,
        clientToken,
        driverToken,
      ];
}

class FixedPos {
  final num heading;
  final num latitude;
  final num longitude;
  final num timestamp;

  const FixedPos({
    @required this.heading,
    @required this.latitude,
    @required this.longitude,
    this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'heading': heading,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
    };
  }

  static FixedPos fromPosition(Position data) {
    return FixedPos(
      heading: data?.heading ?? 0,
      latitude: data?.latitude ?? 0,
      longitude: data?.longitude ?? 0,
      timestamp: data?.timestamp.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
    );
  }

  static FixedPos fromMap(Map<String, dynamic> data) {
    return FixedPos(
      heading: data != null ? data['heading'] : 0,
      latitude: data != null ? data['latitude'] : 0,
      longitude: data != null ? data['longitude'] : 0,
      timestamp: data != null ? data['timestamp'] : 0,
    );
  }
}
