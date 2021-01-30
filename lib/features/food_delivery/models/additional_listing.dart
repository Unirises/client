library additional_listing;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';

part 'additional_listing.g.dart';

abstract class AdditionalListing
    implements Built<AdditionalListing, AdditionalListingBuilder> {
  AdditionalListing._();

  factory AdditionalListing([updates(AdditionalListingBuilder b)]) =
      _$AdditionalListing;

  @BuiltValueField(wireName: 'additionalPrice')
  num get additionalPrice;
  @BuiltValueField(wireName: 'name')
  String get name;
  @nullable
  bool get isSelected;
  String get additionalSKU;

  String toJson() {
    return json
        .encode(serializers.serializeWith(AdditionalListing.serializer, this));
  }

  static AdditionalListing fromJson(String jsonString) {
    return serializers.deserializeWith(
        AdditionalListing.serializer, json.decode(jsonString));
  }

  static Serializer<AdditionalListing> get serializer =>
      _$additionalListingSerializer;
}
