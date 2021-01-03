library bounds;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';

import 'location.dart';

part 'bounds.g.dart';

abstract class Bounds implements Built<Bounds, BoundsBuilder> {
  Bounds._();

  factory Bounds([updates(BoundsBuilder b)]) = _$Bounds;

  @BuiltValueField(wireName: 'northeast')
  Location get northeast;
  @BuiltValueField(wireName: 'southwest')
  Location get southwest;
  String toJson() {
    return json.encode(serializers.serializeWith(Bounds.serializer, this));
  }

  static Bounds fromJson(String jsonString) {
    return serializers.deserializeWith(
        Bounds.serializer, json.decode(jsonString));
  }

  static Serializer<Bounds> get serializer => _$boundsSerializer;
}
