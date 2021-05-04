library built_request;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';
import 'package:client/features/parcel/built_models/distance_duration.dart';

import 'location.dart';

part 'built_stop.g.dart';

abstract class BuiltStop implements Built<BuiltStop, BuiltStopBuilder> {
  String? get houseDetails;
  String? get name;
  String? get phone;
  Location? get location;
  String? get address;
  String? get id;
  num? get weight;
  String? get type;
  bool? get isCashOnDelivery;

  num? get distance;
  num? get price;

  Location? get startLocation;
  Location? get endLocation;

  String? get startAddress;
  String? get endAddress;

  DistanceDuration? get duration;

  String? get specialNote;
  bool? get receiverWillShoulder;
  num? get itemPrice;

  BuiltStop._();

  factory BuiltStop([updates(BuiltStopBuilder b)?]) = _$BuiltStop;

  String toJson() {
    return json.encode(serializers.serializeWith(BuiltStop.serializer, this));
  }

  static BuiltStop? fromJson(String jsonString) {
    return serializers.deserializeWith(
        BuiltStop.serializer, json.decode(jsonString));
  }

  static Serializer<BuiltStop> get serializer => _$builtStopSerializer;
}
