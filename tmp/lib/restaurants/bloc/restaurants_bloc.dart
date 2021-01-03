import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jg_express_client/models/Merchant.dart';
import 'package:meta/meta.dart';

import '../../repository/user_firestore_repository.dart';

part 'restaurants_event.dart';
part 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  RestaurantsBloc({
    @required UserFirestoreRepository userFirestoreRepository,
  })  : assert(userFirestoreRepository != null),
        _userFirestoreRepository = userFirestoreRepository,
        super(RestaurantsInitial());

  final UserFirestoreRepository _userFirestoreRepository;

  @override
  Stream<RestaurantsState> mapEventToState(
    RestaurantsEvent event,
  ) async* {
    if (event is FetchRestaurants) {
      final data = await _userFirestoreRepository.getMerchants();
      List<Merchant> listOfMerchants = [];

      for (var merchant in data) {
        listOfMerchants
            .add(Merchant.fromMap(cast<Map<String, dynamic>>(merchant)));
      }

      listOfMerchants.sort((a, b) => a.distance.compareTo(b.distance));

      yield RestaurantsLoaded(listOfMerchants);
    }
  }
}
