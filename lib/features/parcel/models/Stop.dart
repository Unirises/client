import 'package:client/features/parcel/built_models/location.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Stop extends Equatable {
  final String houseDetails;
  final String name;
  final String phone;
  final Location location; // lat lng
  final String address;
  final String id;

  final num weight;
  final String type;

  const Stop({
    @required this.houseDetails,
    @required this.name,
    @required this.phone,
    @required this.location,
    @required this.id,
    @required this.address,
    this.weight,
    this.type,
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
      ];
}
