import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../models/Store.dart';
import '../../../repositories/store_repository.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository _storeRepository;
  StoreBloc({@required StoreRepository storeRepository})
      : assert(storeRepository != null),
        _storeRepository = storeRepository,
        super(StoreInitial());

  @override
  Stream<StoreState> mapEventToState(
    StoreEvent event,
  ) async* {
    if (event is FetchStore) {
      var stores = await _storeRepository.getStores();
      yield StoresLoaded(stores);
    }
  }
}
