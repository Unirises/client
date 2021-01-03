import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../repository/UserCollection.dart';
import '../repository/user_firestore_repository.dart';

part 'user_collection_event.dart';
part 'user_collection_state.dart';

class UserCollectionBloc
    extends Bloc<UserCollectionEvent, UserCollectionState> {
  UserCollectionBloc({
    @required UserFirestoreRepository userFirestoreRepository,
  })  : assert(userFirestoreRepository != null),
        _userFirestoreRepository = userFirestoreRepository,
        super(UserCollectionInitial());

  final UserFirestoreRepository _userFirestoreRepository;

  @override
  Stream<UserCollectionState> mapEventToState(
    UserCollectionEvent event,
  ) async* {
    final currentState = state;
    if (event is FetchUserCollection) {
      final data = await _userFirestoreRepository.getUserData();
      final _position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      yield currentState.copyWith(
          userCollection:
              UserCollection.fromSnapshotWithPosition(data, _position));
    } else if (event is UpdateUserCollection) {
      await _userFirestoreRepository.updateUserCollection(event.data);
      final data = await _userFirestoreRepository.getUserData();

      yield currentState.copyWith(
          userCollection: UserCollection.fromSnapshot(data));
    }
  }
}
