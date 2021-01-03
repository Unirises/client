import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:client/features/parcel/built_models/built_directions.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import '../models/Client.dart';
import '../models/Request.dart';
import '../pabili_delivery/pabili_delivery_bloc.dart' as PDB;
import '../ride_sharing_bloc/ride_sharing_bloc.dart';
import '../serializers.dart';
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
      final standardSerializers = (serializers.toBuilder()
            ..addPlugin(new StandardJsonPlugin()))
          .build();

      var data = await Dio().get(
          "https://maps.googleapis.com/maps/api/directions/json?origin=14.6894917,121.1120518&destination=14.6998849,121.1262652&waypoints=14.6481305,121.1014372&key=AIzaSyBWlDJm4CJ_PAhhrC0F3powcfmy_NJEn2E");
      var xd = r'''
  {
   "routes" : [
      {
         "bounds" : {
            "northeast" : {
               "lat" : 14.7011438,
               "lng" : 121.1262507
            },
            "southwest" : {
               "lat" : 14.6467889,
               "lng" : 121.0959419
            }
         },
         "legs" : [
            {
               "distance" : {
                  "text" : "9.8 km",
                  "value" : 9838
               },
               "duration" : {
                  "text" : "29 mins",
                  "value" : 1768
               },
               "end_address" : "58 Calamansi Street, 1805, Marikina, 1800 Metro Manila, Philippines",
               "end_location" : {
                  "lat" : 14.6481568,
                  "lng" : 121.1014328
               },
               "start_address" : "7 De Vera Dr, Quezon City, 1100 Metro Manila, Philippines",
               "start_location" : {
                  "lat" : 14.6888416,
                  "lng" : 121.1107301
               }
            },
            {
               "distance" : {
                  "text" : "7.1 km",
                  "value" : 7072
               },
               "duration" : {
                  "text" : "20 mins",
                  "value" : 1203
               },
               "end_address" : "18 Clemente Santos Compound, San Mateo, Rizal, Philippines",
               "end_location" : {
                  "lat" : 14.6998499,
                  "lng" : 121.1262507
               },
               "start_address" : "58 Calamansi Street, 1805, Marikina, 1800 Metro Manila, Philippines",
               "start_location" : {
                  "lat" : 14.6481568,
                  "lng" : 121.1014328
               }
            }
         ],
         "overview_polyline" : {
            "points" : "g|sxAamebVdAc@v@Ub@bBv@UjBk@HCFHNXb@tAA??@A?AB?B?@@DD@B?Vz@Nx@?NSjAcAfEm@|Ba@v@U|@Qf@s@x@ErBErCGh@OXqEtGqCeBcC_BeAs@y@]oGmBo@KJ`BCf@OZ}CvDeAtAe@bAQr@[zA_@`C?JWDi@Ns@Zk@b@_@^[d@_@h@a@Ja@NKJIVcArByB~Bs@t@h@d@PLh@FVHvDnEdBjBrAfARRNCx@EfI@|B@tABZHf@^NNNQnAkAzI_HzFeEd@c@^o@Pg@t@}CLc@Ti@`DkFrBmDrB}CrAiBp@qBVe@|AaBbBaBtOsOjEqEjBuBn@w@f@q@d@w@vAiC`@i@l@f@vEdDlEtC\\LpBXlBZhEr@dF~@bI`BrIhB~HfBvK~B|Cl@fEdAv@NZHf@LdATzEfBhRbH~@ZfA^VDvHn@dHp@v@FdC?jA?zC?lABrBNjAXVHBk@CY_@eBVDr@RvHfCrLpEk@`BeCaAAN?j@DpB]BaBNE_Ad@CBA@CI_AH~@ABC@e@BAMAE?ASAuBI_@AWDMk@Ws@i@kAIMq@s@m@m@q@YWK}Bm@sBOm@AeAAaE?eC?w@GeHq@oIu@}CeA{UyIsAg@u@Qw@Q[Iw@OgEeA}Cm@wK_C_IgBeDq@_IcBwGsAcDk@sGeAqBY]MQK{DiCwEeD_Au@gA{@kA_AkAo@]SY[}AqAwDcDuBwAcCuAqAk@qCgAwBaASGUES?qBCy@GgAGwDQ}AUqEc@wGe@mAK{BQiD[sD_@kDYaCOsAQgAMuBScCSD}CA_@Ca@EMyAmBwBgCa@i@iCaDaBoB_AmA_AiAmCgDy@y@}G{Cs@[`@cBJk@AG?ENSTk@Rg@tAlAv@_CLc@"
         }
      }
   ]
}
  ''';
      BuiltDirections builtDirections = BuiltDirections.fromJson(xd);
      print(builtDirections);
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
    }

    if (event is ClientRequestsRide) {
      var requestId = await _clientRepository.updateStatus(
        data: 'requesting',
        request: event.request,
      );

      event.rideSharingBloc.add(StartListenOnRide(requestId));
    } else if (event is ClientCancelRide) {
      await _clientRepository.updateStatus(
        data: 'idle',
        requestID: event.requestID,
      );

      // await _clientRepository.deleteRequest(event.requestID);
    }

    if (event is ClientRequestFood) {
      // event.pabiliDeliveryBloc.add(PDB.ResetYield());

      var requestId = await _clientRepository.updateDeliveryStatus(
        data: 'requesting',
        request: event.request,
      );

      event.pabiliDeliveryBloc.add(PDB.StartListenOnPabiliRide(requestId));
    } else if (event is ClientCancelRide) {
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
