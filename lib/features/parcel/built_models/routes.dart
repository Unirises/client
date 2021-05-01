library routes;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';

import 'bounds.dart';
import 'legs.dart';
import 'overview_polyline.dart';

part 'routes.g.dart';

abstract class Routes implements Built<Routes, RoutesBuilder> {
  Routes._();

  factory Routes([updates(RoutesBuilder b)?]) = _$Routes;

  @BuiltValueField(wireName: 'bounds')
  Bounds get bounds;
  @BuiltValueField(wireName: 'legs')
  BuiltList<Legs> get legs;
  @BuiltValueField(wireName: 'overview_polyline')
  OverviewPolyline get overviewPolyline;
  String toJson() {
    return json.encode(serializers.serializeWith(Routes.serializer, this));
  }

  static Routes? fromJson(String jsonString) {
    return serializers.deserializeWith(
        Routes.serializer, json.decode(jsonString));
  }

  static Serializer<Routes> get serializer => _$routesSerializer;
}
