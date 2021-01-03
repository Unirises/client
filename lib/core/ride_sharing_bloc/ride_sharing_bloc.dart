import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/Request.dart';
import 'ride_sharing_repository.dart';

part 'ride_sharing_event.dart';
part 'ride_sharing_state.dart';

class RideSharingBloc extends Bloc<RideSharingEvent, RideSharingState> {
  final RideSharingRepository _rideSharingRepository;
  StreamSubscription _rideSubscription;

  RideSharingBloc({@required RideSharingRepository rideSharingRepository})
      : assert(rideSharingRepository != null),
        _rideSharingRepository = rideSharingRepository,
        super(RideSharingInitial());

  @override
  Stream<RideSharingState> mapEventToState(
    RideSharingEvent event,
  ) async* {
    if (event is StartListenOnRide) {
      yield* _mapRideToState(event.ride_id);
    } else if (event is RideUpdated) {
      yield* _mapRideUpdatedToState(event);
    } else if (event is StopListeningOnRide) {
      _rideSubscription?.cancel();
    }
  }

  Stream<RideSharingState> _mapRideToState(String ride_id) async* {
    _rideSubscription?.cancel();
    _rideSubscription = _rideSharingRepository.ride(ride_id).listen((ride) {
      return add(RideUpdated(ride));
    });
  }

  Stream<RideSharingState> _mapRideUpdatedToState(RideUpdated event) async* {
    yield RideSharingLoaded(event.ride);
  }

  @override
  Future<void> close() {
    _rideSubscription?.cancel();
    return super.close();
  }
}
