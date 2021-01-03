part of 'user_collection_bloc.dart';

abstract class UserCollectionEvent extends Equatable {
  const UserCollectionEvent();

  @override
  List<Object> get props => [];
}

class FetchUserCollection extends UserCollectionEvent {}

class UpdateUserCollection extends UserCollectionEvent {
  const UpdateUserCollection(this.data);
  final Map<String, dynamic> data;
}
