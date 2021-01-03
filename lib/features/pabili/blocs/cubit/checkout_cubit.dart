import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../../../../core/client_bloc/client_bloc.dart';
import '../../../../core/models/PlaceLocation.dart';
import '../../../../core/models/Request.dart';
import '../../../../core/pabili_delivery/pabili_delivery_bloc.dart';
import '../../../ride_sharing/models/Payment.dart';
import '../../../ride_sharing/models/Pickup.dart';
import '../../../ride_sharing/models/Transportation.dart';
import '../../models/Item.dart';
import '../../models/Store.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(const CheckoutState());

  void pickupPointChanged(Map<String, dynamic> value) async {
    final pickup = Pickup.dirty(value);
    emit(state.copyWith(
      pickupPoint: pickup,
      status: Formz.validate([
        pickup,
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
        state.transportation,
        payment,
      ]),
    ));
    computeFare();
  }

  void addItem(Item item, Store store) {
    var prevState = [...state.items];
    prevState.add(item);
    emit(state.copyWith(
      store: store,
      items: prevState,
      isInitial: false,
    ));
    computeSubtotal();
  }

  void removeItem(int index) {
    var prevState = [...state.items];
    prevState.removeAt(index);

    emit(state.copyWith(
      items: prevState,
    ));
    computeSubtotal();
  }

  void computeSubtotal() {
    var listOfPrices = [];
    state.items.forEach((element) {
      listOfPrices.add(element.price * element.quantity);
    });
    var total = listOfPrices.reduce((value, element) => value + element);
    emit(state.copyWith(subtotal: total));
  }

  void resetStore() {
    emit(state.copyWith(
      store: null,
      items: [],
      isInitial: true,
    ));
  }

  Future<void> fetchDirections() async {
    if (state.status.isValid) {
      try {
        var directionsResponse = await Dio().get(
            "https://maps.googleapis.com/maps/api/directions/json?origin=${state.pickupPoint.value['coordinates']['lat']},${state.pickupPoint.value['coordinates']['lng']}&destination=${state.store.location.latitude},${state.store.location.longitude}&departure_time=${DateTime.now().millisecondsSinceEpoch}&key=AIzaSyBWlDJm4CJ_PAhhrC0F3powcfmy_NJEn2E");
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
    await remoteConfig.fetch(expiration: const Duration(days: 1));
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
              fee: (total * finalMultiplier).roundToDouble(),
              nonDiscountedFee: total.roundToDouble(),
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
              fee: (total * finalMultiplier).roundToDouble(),
              nonDiscountedFee: total.roundToDouble(),
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
              fee: (total * finalMultiplier).roundToDouble(),
              nonDiscountedFee: total.roundToDouble(),
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

  Future<void> bookFormSubmitted({
    @required ClientBloc clientBloc,
    @required PabiliDeliveryBloc bloc,
    final String phone,
  }) async {
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
      clientBloc.add(ClientRequestFood(
        Request(
          clientToken: deviceToken,
          isFoodDelivery: true,
          isPaidWithCash:
              state.payment.value == PaymentEnum.cash ? true : false,
          isChargePaid:
              state.payment.value == PaymentEnum.cash ? 'false' : 'true',
          userId: FirebaseAuth.instance.currentUser.uid,
          status: 'requesting',
          destination: PlaceLocation(
            address: state.pickupPoint.value['address'],
            latitude: state.pickupPoint.value['coordinates']['lat'],
            longitude: state.pickupPoint.value['coordinates']['lng'],
          ),
          pickup: state.store.location,
          position: goodPos,
          distance: state.duration,
          price: state.fee + state.subtotal,
          clientName: FirebaseAuth.instance.currentUser.displayName,
          clientNumber: phone,
          ride_type: ride_type,
          isParcel: false,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          bounds: state.bounds,
          encodedPolyline: state.encodedPolyline,
          duration: state.duration,
          data: {
            'fee': state.fee,
            'subtotal': state.subtotal,
            'orders': state.items.map((e) => e.toMap()).toList()
          },
        ),
        bloc,
      ));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    }
  }
}
