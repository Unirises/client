library built_request;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';
import 'package:client/features/food_delivery/models/classification_listing.dart';
import 'package:client/features/parcel/built_models/built_directions.dart';
import 'package:client/features/parcel/built_models/built_vehicle_data.dart';

import 'built_position.dart';
import 'built_stop.dart';

part 'built_request.g.dart';

abstract class BuiltRequest
    implements Built<BuiltRequest, BuiltRequestBuilder> {
  @nullable
  String get id;
  @nullable
  String get driverId;
  String get userId;

  String get status;

  BuiltPosition get position;

  @nullable
  String get driverName;
  @nullable
  String get driverNumber;
  String get clientName;
  String get clientNumber;

  String get rideType;
  bool get isParcel;
  @nullable
  BuiltVehicleData get vehicleData;
  @nullable
  String get driverToken;
  String get clientToken;

  @nullable
  num get averageTimePreparation;

  BuiltDirections get directions;

  @nullable
  int get currentIndex;
  BuiltStop get pickup;

  @nullable
  BuiltStop get destination;
  @nullable
  BuiltList<ClassificationListing> get items;

  BuiltList<BuiltStop> get points;
  @nullable
  num get timestamp;

  @nullable
  num get subtotal;
  num get fee;

  BuiltRequest._();

  factory BuiltRequest([updates(BuiltRequestBuilder b)]) = _$BuiltRequest;

  String toJson() {
    return json
        .encode(serializers.serializeWith(BuiltRequest.serializer, this));
  }

  static BuiltRequest fromJson(String jsonString) {
    return serializers.deserializeWith(
        BuiltRequest.serializer, json.decode(jsonString));
  }

  static Serializer<BuiltRequest> get serializer => _$builtRequestSerializer;
}
