library distance_duration;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';

part 'distance_duration.g.dart';

abstract class DistanceDuration
    implements Built<DistanceDuration, DistanceDurationBuilder> {
  DistanceDuration._();

  factory DistanceDuration([updates(DistanceDurationBuilder b)?]) =
      _$DistanceDuration;

  @BuiltValueField(wireName: 'text')
  String get text;
  @BuiltValueField(wireName: 'value')
  int get value;
  String toJson() {
    return json
        .encode(serializers.serializeWith(DistanceDuration.serializer, this));
  }

  static DistanceDuration? fromJson(String jsonString) {
    return serializers.deserializeWith(
        DistanceDuration.serializer, json.decode(jsonString));
  }

  static Serializer<DistanceDuration> get serializer =>
      _$distanceDurationSerializer;
}
