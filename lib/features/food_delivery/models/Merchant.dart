import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../parcel/built_models/location.dart';
import 'merchant_listing.dart';

class Merchant extends Equatable {
  final String id;
  final MerchantListing listing;
  final String address;
  final num averageTimePreparation;
  final String companyName;

  final String hero;
  final String phone;
  final String photo;
  final Location place;
  final String startTime;
  final String endTime;
  final Map<String, dynamic> representative;

  const Merchant({
    @required this.id,
    this.address,
    this.averageTimePreparation,
    this.companyName,
    this.hero,
    this.photo,
    this.place,
    this.startTime,
    this.endTime,
    this.listing,
    this.phone,
    this.representative,
  }) : assert(id != null);

  @override
  List<Object> get props => [
        id,
        address,
        averageTimePreparation,
        companyName,
        hero,
        photo,
        place,
        startTime,
        endTime,
        listing,
        phone,
        representative,
      ];
}
