import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class UserCollection extends Equatable {
  const UserCollection({
    this.name,
    this.phone,
    this.email,
    this.type,
    this.photo,
    this.position,
  });

  final String name;
  final String phone;
  final String email;
  final String type;
  final String photo;
  final Position position;

  @override
  List<Object> get props => [
        name,
        phone,
        email,
        type,
        photo,
        position,
      ];

  static const empty = UserCollection(
    name: '',
    phone: '',
    email: '',
    type: '',
    photo: '',
    position: null,
  );

  static UserCollection fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data();
    return UserCollection(
      name: data['name'].toString(),
      phone: data['phone'].toString(),
      email: data['email'].toString(),
      type: data['type'].toString() ?? 'client',
      photo: data['photo']?.toString() ?? '',
    );
  }

  static UserCollection fromSnapshotWithPosition(
      DocumentSnapshot snapshot, Position position) {
    final data = snapshot.data();
    return UserCollection(
      name: data['name'].toString(),
      phone: data['phone'].toString(),
      email: data['email'].toString(),
      type: data['type'].toString() ?? 'client',
      photo: data['photo']?.toString() ?? '',
      position: position,
    );
  }
}
