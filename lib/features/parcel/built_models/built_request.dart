library built_request;

import 'package:built_value/built_value.dart';
import 'package:client/core/models/Request.dart';
import 'package:client/features/parcel/models/Stop.dart';

part 'built_request.g.dart';

abstract class BuiltRequest
    implements Built<BuiltRequest, BuiltRequestBuilder> {
  String get driverId;
  String get userId;

  String get status;

  FixedPos get position;

  String get driverName;
  String get driverNumber;
  String get clientName;
  String get clientNumber;

  String get rideType;
  bool get isParcel;
  Map<String, dynamic> get vehicleData;
  String get driverToken;
  String get clientToken;

  int get currentIndex;
  Stop get pickup;
  List<Stop> get points;

  BuiltRequest._();

  factory BuiltRequest([updates(BuiltRequestBuilder b)]) = _$BuiltRequest;
}
