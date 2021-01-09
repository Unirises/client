library built_request;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';
import 'package:client/features/parcel/built_models/distance_duration.dart';

import 'location.dart';

part 'built_stop.g.dart';

abstract class BuiltStop implements Built<BuiltStop, BuiltStopBuilder> {
  @nullable
  String get houseDetails;
  @nullable
  String get name;
  @nullable
  String get phone;
  @nullable
  Location get location; // lat lng
  @nullable
  String get address;
  @nullable
  String get id;
  @nullable
  num get weight;
  @nullable
  String get type;
  @nullable
  bool get isCashOnDelivery;

  @nullable
  num get distance;
  @nullable
  num get price;

  @nullable
  Location get startLocation;
  @nullable
  Location get endLocation;

  @nullable
  String get startAddress;
  @nullable
  String get endAddress;

  @nullable
  DistanceDuration get duration;

  BuiltStop._();

  factory BuiltStop([updates(BuiltStopBuilder b)]) = _$BuiltStop;

  String toJson() {
    return json.encode(serializers.serializeWith(BuiltStop.serializer, this));
  }

  static BuiltStop fromJson(String jsonString) {
    return serializers.deserializeWith(
        BuiltStop.serializer, json.decode(jsonString));
  }

  static Serializer<BuiltStop> get serializer => _$builtStopSerializer;
}
