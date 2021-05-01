part of 'user_collection_bloc.dart';

abstract class UserCollectionState extends Equatable {
  const UserCollectionState({this.userCollection});

  final User? userCollection;

  @override
  List<Object?> get props => [userCollection];

  UserCollectionLoaded copyWith({User? userCollection}) {
    return UserCollectionLoaded(userCollection ?? this.userCollection);
  }
}

class UserCollectionInitial extends UserCollectionState {}

class UserCollectionLoaded extends UserCollectionState {
  const UserCollectionLoaded(this.userCollection);

  @override
  final User? userCollection;
}
