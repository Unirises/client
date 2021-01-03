library built_directions;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';
import 'package:client/features/parcel/built_models/routes.dart';

part 'built_directions.g.dart';

abstract class BuiltDirections
    implements Built<BuiltDirections, BuiltDirectionsBuilder> {
  BuiltDirections._();

  factory BuiltDirections([updates(BuiltDirectionsBuilder b)]) =
      _$BuiltDirections;

  @BuiltValueField(wireName: 'routes')
  BuiltList<Routes> get routes;
  String toJson() {
    return json
        .encode(serializers.serializeWith(BuiltDirections.serializer, this));
  }

  static BuiltDirections fromJson(String jsonString) {
    return serializers.deserializeWith(
        BuiltDirections.serializer, json.decode(jsonString));
  }

  static Serializer<BuiltDirections> get serializer =>
      _$builtDirectionsSerializer;
}
