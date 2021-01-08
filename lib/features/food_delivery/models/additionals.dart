library additionals;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';

import 'additional_listing.dart';

part 'additionals.g.dart';

abstract class Additionals implements Built<Additionals, AdditionalsBuilder> {
  Additionals._();

  factory Additionals([updates(AdditionalsBuilder b)]) = _$Additionals;

  @BuiltValueField(wireName: 'minMax')
  BuiltList<int> get minMax;
  @BuiltValueField(wireName: 'additionalListing')
  BuiltList<AdditionalListing> get additionalListing;
  @BuiltValueField(wireName: 'type')
  String get type;
  @BuiltValueField(wireName: 'additionalName')
  String get additionalName;
  String toJson() {
    return json.encode(serializers.serializeWith(Additionals.serializer, this));
  }

  static Additionals fromJson(String jsonString) {
    return serializers.deserializeWith(
        Additionals.serializer, json.decode(jsonString));
  }

  static Serializer<Additionals> get serializer => _$additionalsSerializer;
}
