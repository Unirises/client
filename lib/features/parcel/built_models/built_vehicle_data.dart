library built_request;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';

part 'built_vehicle_data.g.dart';

abstract class BuiltVehicleData
    implements Built<BuiltVehicleData, BuiltVehicleDataBuilder> {
  String get brand;
  String get color;
  String get model;
  String get plate;

  BuiltVehicleData._();

  factory BuiltVehicleData([updates(BuiltVehicleDataBuilder b)?]) =
      _$BuiltVehicleData;

  String toJson() {
    return json
        .encode(serializers.serializeWith(BuiltVehicleData.serializer, this));
  }

  static BuiltVehicleData? fromJson(String jsonString) {
    return serializers.deserializeWith(
        BuiltVehicleData.serializer, json.decode(jsonString));
  }

  static Serializer<BuiltVehicleData> get serializer =>
      _$builtVehicleDataSerializer;
}
