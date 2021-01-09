library built_request;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';

part 'built_position.g.dart';

abstract class BuiltPosition
    implements Built<BuiltPosition, BuiltPositionBuilder> {
  num get heading;
  num get latitude;
  num get longitude;
  num get timestamp;
  BuiltPosition._();

  factory BuiltPosition([updates(BuiltPositionBuilder b)]) = _$BuiltPosition;

  String toJson() {
    return json
        .encode(serializers.serializeWith(BuiltPosition.serializer, this));
  }

  static BuiltPosition fromJson(String jsonString) {
    return serializers.deserializeWith(
        BuiltPosition.serializer, json.decode(jsonString));
  }

  static Serializer<BuiltPosition> get serializer => _$builtPositionSerializer;
}
