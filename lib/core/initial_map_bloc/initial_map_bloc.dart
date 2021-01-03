import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../client_bloc/client_repository.dart';
import '../models/Driver.dart';

part 'initial_map_event.dart';
part 'initial_map_state.dart';

class InitialMapBloc extends Bloc<InitialMapEvent, InitialMapState> {
  final ClientRepository _clientRepository;
  StreamSubscription _driversSubscription;

  InitialMapBloc({@required ClientRepository clientRepository})
      : assert(clientRepository != null),
        _clientRepository = clientRepository,
        super(InitialMapInitial());

  @override
  Stream<InitialMapState> mapEventToState(
    InitialMapEvent event,
  ) async* {
    if (event is FetchNearbyDrivers) {
      yield* _mapClientToState();
    } else if (event is NearbyDriversUpdated) {
      yield* _mapClientUpdatedToState(event);
    }

    if (event is StopFetchingNearbyDrivers) {
      _driversSubscription?.cancel();
    }
  }

  Stream<InitialMapState> _mapClientToState() async* {
    _driversSubscription?.cancel();
    _driversSubscription = _clientRepository.drivers().listen((drivers) {
      return add(NearbyDriversUpdated(drivers));
    });
  }

  Stream<InitialMapState> _mapClientUpdatedToState(
      NearbyDriversUpdated event) async* {
    yield NearbyDriversLoaded(event.drivers);
  }

  @override
  Future<void> close() {
    _driversSubscription?.cancel();
    return super.close();
  }
}
