library overview_polyline;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';

part 'overview_polyline.g.dart';

abstract class OverviewPolyline
    implements Built<OverviewPolyline, OverviewPolylineBuilder> {
  OverviewPolyline._();

  factory OverviewPolyline([updates(OverviewPolylineBuilder b)]) =
      _$OverviewPolyline;

  @BuiltValueField(wireName: 'points')
  String get points;
  String toJson() {
    return json
        .encode(serializers.serializeWith(OverviewPolyline.serializer, this));
  }

  static OverviewPolyline fromJson(String jsonString) {
    return serializers.deserializeWith(
        OverviewPolyline.serializer, json.decode(jsonString));
  }

  static Serializer<OverviewPolyline> get serializer =>
      _$overviewPolylineSerializer;
}
