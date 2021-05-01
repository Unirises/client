library distance;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';

part 'distance.g.dart';

abstract class Distance implements Built<Distance, DistanceBuilder> {
  Distance._();

  factory Distance([updates(DistanceBuilder b)?]) = _$Distance;

  @BuiltValueField(wireName: 'text')
  String get text;
  @BuiltValueField(wireName: 'value')
  int get value;
  String toJson() {
    return json.encode(serializers.serializeWith(Distance.serializer, this));
  }

  static Distance? fromJson(String jsonString) {
    return serializers.deserializeWith(
        Distance.serializer, json.decode(jsonString));
  }

  static Serializer<Distance> get serializer => _$distanceSerializer;
}
