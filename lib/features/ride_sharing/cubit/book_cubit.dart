import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/client_bloc/client_bloc.dart';
import '../../../core/models/PlaceLocation.dart';
import '../../../core/models/Request.dart';
import '../../../core/ride_sharing_bloc/ride_sharing_bloc.dart';
import '../models/Dropoff.dart';
import '../models/Payment.dart';
import '../models/Pickup.dart';
import '../models/Transportation.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(const BookState());

  void pickupPointChanged(Map<String, dynamic> value) async {
    final pickup = Pickup.dirty(value);
    emit(state.copyWith(
      pickupPoint: pickup,
      status: Formz.validate([
        pickup,
        state.dropoffPoint,
        state.transportation,
        state.payment,
      ]),
    ));
    await fetchDirections();
    computeFare();
  }

  void dropoffPointChanged(Map<String, dynamic> value) async {
    final dropoff = Dropoff.dirty(value);
    emit(state.copyWith(
      dropoffPoint: dropoff,
      status: Formz.validate([
        state.pickupPoint,
        dropoff,
        state.transportation,
        state.payment,
      ]),
    ));
    await fetchDirections();
    computeFare();
  }

  void transportationChanged(TransportationEnum value) {
    final transportation = Transportation.dirty(value);
    emit(state.copyWith(
      transportation: transportation,
      status: Formz.validate([
        state.pickupPoint,
        state.dropoffPoint,
        transportation,
        state.payment,
      ]),
    ));
    computeFare();
  }

  void paymentChanged(PaymentEnum value) {
    final payment = Payment.dirty(value);
    emit(state.copyWith(
      payment: payment,
      status: Formz.validate([
        state.pickupPoint,
        state.dropoffPoint,
        state.transportation,
        payment
      ]),
    ));
    computeFare();
  }

  void parcelChanged(bool value) {
    emit(state.copyWith(
      isParcel: value,
    ));
  }

  Future<void> fetchDirections() async {
    if (state.status.isValid) {
      try {
        var directionsResponse = await Dio().get(
            "https://maps.googleapis.com/maps/api/directions/json?origin=${state.pickupPoint.value['coordinates']['lat']},${state.pickupPoint.value['coordinates']['lng']}&destination=${state.dropoffPoint.value['coordinates']['lat']},${state.dropoffPoint.value['coordinates']['lng']}&departure_time=${DateTime.now().millisecondsSinceEpoch}&key=AIzaSyBWlDJm4CJ_PAhhrC0F3powcfmy_NJEn2E");
        emit(state.copyWith(data: directionsResponse.data));
      } catch (e) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
        ));
      }
    }
  }

  void computeFare() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    final defaults = <String, dynamic>{'multiplier': 1};
    await remoteConfig.setDefaults(defaults);
    await remoteConfig.fetch(expiration: const Duration(minutes: 15));
    await remoteConfig.activateFetched();
    final finalMultiplier = remoteConfig.getDouble('multiplier');

    if (state.status.isValid) {
      try {
        var distanceKm =
            state.data['routes'][0]['legs'][0]['distance']['value'] / 1000;

        switch (state.transportation.value) {
          case TransportationEnum.car2Seater:
            var baseFare = 60;
            var succeedingKm = 12;
            var after7km = 15;

            var total = baseFare + (succeedingKm * distanceKm);
            if (distanceKm >= 7) {
              total += after7km;
            }

            emit(state.copyWith(
              total: (total * finalMultiplier).roundToDouble(),
              nonDiscountedTotal: total.roundToDouble(),
              bounds: state.data['routes'][0]['bounds'],
              distance: state.data['routes'][0]['legs'][0]['distance']['value'],
              duration: state.data['routes'][0]['legs'][0]
                  ['duration_in_traffic']['value'],
              encodedPolyline: state.data['routes'][0]['overview_polyline']
                  ['points'],
            ));
            break;
          case TransportationEnum.car4Seater:
            var baseFare = 65;
            var succeedingKm = 12;
            var after7km = 15;

            var total = baseFare + (succeedingKm * distanceKm);
            if (distanceKm >= 7) {
              total += after7km;
            }

            emit(state.copyWith(
              total: (total * finalMultiplier).roundToDouble(),
              nonDiscountedTotal: total.roundToDouble(),
              bounds: state.data['routes'][0]['bounds'],
              distance: state.data['routes'][0]['legs'][0]['distance']['value'],
              duration: state.data['routes'][0]['legs'][0]
                  ['duration_in_traffic']['value'],
              encodedPolyline: state.data['routes'][0]['overview_polyline']
                  ['points'],
            ));
            break;
          case TransportationEnum.motorcycle:
            var baseFare = 50.0; // for the first 2 km
            var succeedingKm = 12;
            var after7km = 15;

            var billableDistance = distanceKm - 2;
            double total = 0;
            if (billableDistance <= 0) {
              total = baseFare;
            } else {
              total = baseFare + (succeedingKm * distanceKm);
              if (distanceKm >= 7) {
                total += after7km;
              }
            }
            emit(state.copyWith(
              total: (total * finalMultiplier).roundToDouble(),
              nonDiscountedTotal: total.roundToDouble(),
              bounds: state.data['routes'][0]['bounds'],
              distance: state.data['routes'][0]['legs'][0]['distance']['value'],
              duration: state.data['routes'][0]['legs'][0]
                  ['duration_in_traffic']['value'],
              encodedPolyline: state.data['routes'][0]['overview_polyline']
                  ['points'],
            ));
            break;
        }
      } catch (e) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
        ));
      }
    }
  }

  Future<void> bookFormSubmitted(
    ClientBloc clientBloc,
    RideSharingBloc rideSharingBloc,
    final String phone,
  ) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      var ride_type = '';
      switch (state.transportation.value) {
        case TransportationEnum.car2Seater:
          ride_type = 'car2Seater';
          break;
        case TransportationEnum.car4Seater:
          ride_type = 'car4Seater';
          break;
        case TransportationEnum.motorcycle:
          ride_type = 'motorcycle';
          break;
      }

      var shittyPos = await Geolocator.getCurrentPosition();
      var goodPos = FixedPos.fromPosition(shittyPos);
      var deviceToken = await FirebaseMessaging.instance.getToken();
      clientBloc.add(ClientRequestsRide(
        Request(
          clientToken: deviceToken,
          isFoodDelivery: false,
          isPaidWithCash:
              state.payment.value == PaymentEnum.cash ? true : false,
          isChargePaid:
              state.payment.value == PaymentEnum.cash ? 'false' : 'true',
          userId: FirebaseAuth.instance.currentUser.uid,
          status: 'requesting',
          pickup: PlaceLocation(
            address: state.pickupPoint.value['address'],
            latitude: state.pickupPoint.value['coordinates']['lat'],
            longitude: state.pickupPoint.value['coordinates']['lng'],
          ),
          destination: PlaceLocation(
            address: state.dropoffPoint.value['address'],
            latitude: state.dropoffPoint.value['coordinates']['lat'],
            longitude: state.dropoffPoint.value['coordinates']['lng'],
          ),
          position: goodPos,
          distance: state.duration,
          price: state.total,
          clientName: FirebaseAuth.instance.currentUser.displayName,
          clientNumber: phone,
          ride_type: ride_type,
          isParcel: state.isParcel == true,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          bounds: state.bounds,
          encodedPolyline: state.encodedPolyline,
          duration: state.duration,
        ),
        rideSharingBloc,
      ));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    }
  }
}
