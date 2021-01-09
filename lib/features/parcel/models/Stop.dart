import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../built_models/location.dart';

class Stop extends Equatable {
  final String houseDetails;
  final String name;
  final String phone;
  final Location location; // lat lng
  final String address;
  final String id;

  final num weight;
  final String type;
  final bool isCashOnDelivery;

  final num distance;
  final num price;

  final Location startLocation;
  final Location endLocation;

  final String startAddress;
  final String endAddress;

  const Stop({
    this.houseDetails,
    @required this.name,
    @required this.phone,
    @required this.location,
    @required this.id,
    @required this.address,
    this.weight,
    this.type,
    this.isCashOnDelivery,
    this.distance,
    this.price,
    this.startLocation,
    this.endLocation,
    this.startAddress,
    this.endAddress,
  });

  @override
  List<Object> get props => [
        id,
        this.houseDetails,
        name,
        phone,
        location,
        address,
        weight,
        type,
        isCashOnDelivery,
        distance,
        price,
        startLocation,
        endLocation,
        startAddress,
        endAddress,
      ];
}
