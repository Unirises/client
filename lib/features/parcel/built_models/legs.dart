library legs;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';
import 'package:client/features/parcel/built_models/distance_duration.dart';
import 'package:client/features/parcel/built_models/location.dart';

import 'distance.dart';

part 'legs.g.dart';

abstract class Legs implements Built<Legs, LegsBuilder> {
  Legs._();

  factory Legs([updates(LegsBuilder b)]) = _$Legs;

  @BuiltValueField(wireName: 'distance')
  Distance get distance;
  @BuiltValueField(wireName: 'duration')
  DistanceDuration get duration;
  @BuiltValueField(wireName: 'end_address')
  String get endAddress;
  @BuiltValueField(wireName: 'end_location')
  Location get endLocation;
  @BuiltValueField(wireName: 'start_address')
  String get startAddress;
  @BuiltValueField(wireName: 'start_location')
  Location get startLocation;
  String toJson() {
    return json.encode(serializers.serializeWith(Legs.serializer, this));
  }

  static Legs fromJson(String jsonString) {
    return serializers.deserializeWith(
        Legs.serializer, json.decode(jsonString));
  }

  static Serializer<Legs> get serializer => _$legsSerializer;
}
