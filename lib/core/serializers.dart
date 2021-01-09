library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:client/features/food_delivery/models/additional_listing.dart';
import 'package:client/features/food_delivery/models/additionals.dart';
import 'package:client/features/food_delivery/models/classification_listing.dart';
import 'package:client/features/food_delivery/models/listing.dart';
import 'package:client/features/food_delivery/models/merchant_listing.dart';
import 'package:client/features/parcel/built_models/bounds.dart';
import 'package:client/features/parcel/built_models/built_directions.dart';
import 'package:client/features/parcel/built_models/built_position.dart';
import 'package:client/features/parcel/built_models/built_request.dart';
import 'package:client/features/parcel/built_models/built_stop.dart';
import 'package:client/features/parcel/built_models/distance.dart';
import 'package:client/features/parcel/built_models/distance_duration.dart';
import 'package:client/features/parcel/built_models/legs.dart';
import 'package:client/features/parcel/built_models/location.dart';
import 'package:client/features/parcel/built_models/overview_polyline.dart';
import 'package:client/features/parcel/built_models/routes.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  AdditionalListing,
  Additionals,
  ClassificationListing,
  Listing,
  BuiltDirections,
  Routes,
  Legs,
  Bounds,
  Distance,
  DistanceDuration,
  Location,
  OverviewPolyline,
  BuiltStop,
  BuiltRequest,
  BuiltPosition,
  MerchantListing,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
