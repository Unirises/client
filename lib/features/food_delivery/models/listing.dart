library listing;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';

import 'classification_listing.dart';

part 'listing.g.dart';

abstract class Listing implements Built<Listing, ListingBuilder> {
  Listing._();

  factory Listing([updates(ListingBuilder b)?]) = _$Listing;

  @BuiltValueField(wireName: 'classificationName')
  String get classificationName;
  @BuiltValueField(wireName: 'classificationListing')
  BuiltList<ClassificationListing> get classificationListing;
  String toJson() {
    return json.encode(serializers.serializeWith(Listing.serializer, this));
  }

  static Listing? fromJson(String jsonString) {
    return serializers.deserializeWith(
        Listing.serializer, json.decode(jsonString));
  }

  static Serializer<Listing> get serializer => _$listingSerializer;
}
