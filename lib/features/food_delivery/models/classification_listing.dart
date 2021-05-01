library classification_listing;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';

import 'additionals.dart';

part 'classification_listing.g.dart';

abstract class ClassificationListing
    implements Built<ClassificationListing, ClassificationListingBuilder> {
  ClassificationListing._();

  factory ClassificationListing([updates(ClassificationListingBuilder b)?]) =
      _$ClassificationListing;

  @BuiltValueField(wireName: 'itemName')
  String get itemName;
  @BuiltValueField(wireName: 'additionals')
  BuiltList<Additionals> get additionals;
  @BuiltValueField(wireName: 'itemPhoto')
  String? get itemPhoto;
  @BuiltValueField(wireName: 'itemPrice')
  num get itemPrice;
  @BuiltValueField(wireName: 'itemSize')
  String? get itemSize;
  int? get quantity;
  bool? get isValid;
  num? get additionalPrice;
  String get sku;
  bool? get isAvailable;

  String toJson() {
    return json.encode(
        serializers.serializeWith(ClassificationListing.serializer, this));
  }

  static ClassificationListing? fromJson(String jsonString) {
    return serializers.deserializeWith(
        ClassificationListing.serializer, json.decode(jsonString));
  }

  static Serializer<ClassificationListing> get serializer =>
      _$classificationListingSerializer;
}
