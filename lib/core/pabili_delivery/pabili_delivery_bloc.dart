import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/Request.dart';
import 'pabili_delivery_repository.dart';

part 'pabili_delivery_event.dart';
part 'pabili_delivery_state.dart';

class PabiliDeliveryBloc
    extends Bloc<PabiliDeliveryEvent, PabiliDeliveryState> {
  final PabiliDeliveryRepository _repository;
  StreamSubscription _rideSubscription;
  PabiliDeliveryBloc({PabiliDeliveryRepository repository})
      : assert(repository != null),
        _repository = repository,
        super(PabiliDeliveryInitial());

  @override
  Stream<PabiliDeliveryState> mapEventToState(
    PabiliDeliveryEvent event,
  ) async* {
    if (event is StartListenOnPabiliRide) {
      yield* _mapRideToState(event.ride_id);
    } else if (event is RideUpdated) {
      yield* _mapRideUpdatedToState(event);
    } else if (event is StopListenOnPabiliRide) {
      _rideSubscription?.cancel();
    }

    if (event is ResetYield) {
      _rideSubscription?.cancel();
      yield PabiliDeliveryInitial();
    }

    if (event is AddFinishedRideToUser) {
      _repository.addFinishedRideToData(event.request);
      _repository.addFinishedRideToClientData(event.request);
    }
  }

  Stream<PabiliDeliveryState> _mapRideToState(String ride_id) async* {
    _rideSubscription?.cancel();
    _rideSubscription = _repository.order(ride_id).listen((ride) {
      return add(RideUpdated(ride));
    });
  }

  Stream<PabiliDeliveryState> _mapRideUpdatedToState(RideUpdated event) async* {
    switch (event.ride.status) {
      case 'completed':
        this.add(AddFinishedRideToUser(event.ride));
        this.add(StopListenOnPabiliRide());
        break;
      case 'cancelled':
        this.add(AddFinishedRideToUser(event.ride));
        this.add(StopListenOnPabiliRide());
        break;
    }
    yield PabiliDeliveryLoaded(event.ride);
  }

  @override
  Future<void> close() {
    _rideSubscription?.cancel();
    return super.close();
  }
}
