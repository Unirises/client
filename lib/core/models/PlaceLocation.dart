import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PlaceLocation extends Equatable {
  final String place;
  final String address;
  final double latitude;
  final double longitude;

  PlaceLocation({
    this.place,
    @required this.address,
    @required this.latitude,
    @required this.longitude,
  });

  @override
  List<Object> get props => [place, address, latitude, longitude];

  static PlaceLocation fromMap(Map<String, dynamic> map) {
    return PlaceLocation(
        place: map['place'],
        address: map['address'],
        latitude: map['latitude'],
        longitude: map['longitude']);
  }

  Map<String, dynamic> toMap() {
    return {
      'place': place,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
