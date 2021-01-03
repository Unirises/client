import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/Request.dart';
import 'request_repository.dart';

part 'requests_event.dart';
part 'requests_state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  final RequestRepository _requestsRepository;
  StreamSubscription _rideSubscription;
  RequestsBloc({@required RequestRepository requestRepository})
      : assert(requestRepository != null),
        _requestsRepository = requestRepository,
        super(RequestsInitial());

  @override
  Stream<RequestsState> mapEventToState(
    RequestsEvent event,
  ) async* {
    if (event is StartListenOnCurrentRide) {
      yield* _mapCurrentRideToState(event.rideId);
    } else if (event is CurrentRideUpdated) {
      yield* _mapCurrentRideUpdatedToState(event);
    } else if (event is StopListenOnCurrentRide) {
      _rideSubscription?.cancel();
      yield RequestsInitial();
    }

    if (event is AddFinishedRideToUser) {
      _requestsRepository.addFinishedRideToData(event.request);
      _requestsRepository.addFinishedRideToClientData(event.request);
    }
  }

  Stream<RequestsState> _mapCurrentRideToState(String documentId) async* {
    _rideSubscription?.cancel();
    _rideSubscription =
        _requestsRepository.currentRide(documentId).listen((event) {
      return add(CurrentRideUpdated(event));
    });
  }

  Stream<RequestsState> _mapCurrentRideUpdatedToState(
      CurrentRideUpdated event) async* {
    switch (event.request.status) {
      case 'completed':
        this.add(AddFinishedRideToUser(event.request));
        this.add(StopListenOnCurrentRide());
        break;
      case 'cancelled':
        this.add(AddFinishedRideToUser(event.request));
        this.add(StopListenOnCurrentRide());
        break;
    }
    yield CurrentRideLoaded(event.request);
  }

  @override
  Future<void> close() {
    _rideSubscription?.cancel();
    return super.close();
  }
}
