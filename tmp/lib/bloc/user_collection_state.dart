part of 'user_collection_bloc.dart';

abstract class UserCollectionState extends Equatable {
  const UserCollectionState({this.userCollection});

  final UserCollection userCollection;

  @override
  List<Object> get props => [userCollection];

  UserCollectionLoaded copyWith({UserCollection userCollection}) {
    return UserCollectionLoaded(userCollection ?? this.userCollection);
  }
}

class UserCollectionInitial extends UserCollectionState {}

class UserCollectionLoaded extends UserCollectionState {
  const UserCollectionLoaded(this.userCollection);

  @override
  // ignore: overridden_fields
  final UserCollection userCollection;
}
