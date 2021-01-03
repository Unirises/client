part of 'user_collection_bloc.dart';

abstract class UserCollectionEvent extends Equatable {
  const UserCollectionEvent();
}

class FetchUserCollection extends UserCollectionEvent {
  @override
  List<Object> get props => [];
}

class UpdateUserCollection extends UserCollectionEvent {
  const UpdateUserCollection(this.data);
  final Map<String, dynamic> data;

  @override
  List<Object> get props => [data];
}
