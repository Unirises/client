import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

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

      yield currentState.copyWith(userCollection: User.fromSnapshot(data));
    } else if (event is UpdateUserCollection) {
      await _userFirestoreRepository.updateUserCollection(event.data);
      final data = await _userFirestoreRepository.getUserData();
      yield currentState.copyWith(userCollection: User.fromSnapshot(data));
    }
  }
}
