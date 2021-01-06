library built_request;

import 'package:built_value/built_value.dart';

import 'location.dart';
part 'built_stop.g.dart';

abstract class BuiltStop implements Built<BuiltStop, BuiltStopBuilder> {
  String get houseDetails;
  String get name;
  String get phone;
  Location get location; // lat lng
  String get address;
  String get id;
  num get weight;
  String get type;
  bool get isCashOnDelivery;

  num get distance;
  num get price;

  Location get startLocation;
  Location get endLocation;

  String get startAddress;
  String get endAddress;

  BuiltStop._();

  factory BuiltStop([updates(BuiltStopBuilder b)]) = _$BuiltStop;
}
