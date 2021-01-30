import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../models/Client.dart';
import 'client_repository.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientRepository _clientRepository;
  StreamSubscription _clientSubscription;
  StreamSubscription _positionSubscription;
  ClientBloc({@required ClientRepository clientRepository})
      : assert(clientRepository != null),
        _clientRepository = clientRepository,
        super(ClientInitial());

  @override
  Stream<ClientState> mapEventToState(
    ClientEvent event,
  ) async* {
    if (event is FetchClient) {
      yield* _mapClientToState();

      var deviceToken = await FirebaseMessaging.instance.getToken();
      _clientRepository.updateToken(deviceToken);
    } else if (event is ClientUpdated) {
      yield* _mapClientUpdatedToState(event);
    }

    if (event is StartLocationUpdate) {
      _positionSubscription?.cancel();
      _positionSubscription = Geolocator.getPositionStream(
              desiredAccuracy: LocationAccuracy.bestForNavigation,
              intervalDuration: Duration(minutes: 5))
          .listen((event) {
        _clientRepository.updatePosition(event);
      });
    } else if (event is StopLocationUpdate) {
      _positionSubscription?.cancel();
    } else if (event is ClientCancelRide) {
      await _clientRepository.updateStatus(
        data: 'idle',
        requestID: event.requestID,
      );
    } else if (event is ClientCancelFoodRide) {
      await _clientRepository.updateDeliveryStatus(
        data: 'idle',
        requestID: event.requestID,
      );
    }
  }

  Stream<ClientState> _mapClientToState() async* {
    _clientSubscription?.cancel();
    _clientSubscription = _clientRepository.client().listen((driver) {
      return add(ClientUpdated(driver));
    });
  }

  Stream<ClientState> _mapClientUpdatedToState(ClientUpdated event) async* {
    yield ClientLoaded(event.client);
  }

  @override
  Future<void> close() {
    _clientSubscription?.cancel();
    return super.close();
  }
}
