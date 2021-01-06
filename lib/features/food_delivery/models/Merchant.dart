import 'package:client/features/parcel/built_models/location.dart';
import 'package:equatable/equatable.dart';

class Merchant extends Equatable {
  final List<dynamic> listing;
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
  });

  @override
  List<Object> get props => [
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
