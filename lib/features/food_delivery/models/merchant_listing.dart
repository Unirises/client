library listing;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:client/core/serializers.dart';
import 'package:client/features/food_delivery/models/listing.dart';

part 'merchant_listing.g.dart';

abstract class MerchantListing
    implements Built<MerchantListing, MerchantListingBuilder> {
  MerchantListing._();

  factory MerchantListing([updates(MerchantListingBuilder b)]) =
      _$MerchantListing;
  BuiltList<Listing> get listing;
  String toJson() {
    return json
        .encode(serializers.serializeWith(MerchantListing.serializer, this));
  }

  static MerchantListing fromJson(String jsonString) {
    return serializers.deserializeWith(
        MerchantListing.serializer, json.decode(jsonString));
  }

  static Serializer<MerchantListing> get serializer =>
      _$merchantListingSerializer;
}
