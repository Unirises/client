import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/client_bloc/client_bloc.dart';
import '../../core/requests_bloc/requests_bloc.dart';
import 'arrive_view.dart';
import 'initial_map_view.dart';
import 'on_transit_page.dart';
import 'requesting_page.dart';

class RideSharingInitialPage extends StatefulWidget {
  @override
  _RideSharingInitialPageState createState() => _RideSharingInitialPageState();
}

class _RideSharingInitialPageState extends State<RideSharingInitialPage> {
  @override
  void initState() {
    super.initState();
    requestForPermission();
  }

  requestForPermission() async {
    await Geolocator.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        if (state is ClientLoaded) {
          if (state.client.status == 'idle') {
            return InitialMapView();
          } else if (state.client.status == 'requesting') {
            return RequestingPage();
          } else {
            return BlocBuilder<RequestsBloc, RequestsState>(
              builder: (context, requestState) {
                if (requestState is CurrentRideLoaded) {
                  if (requestState.request.status == 'arriving' ||
                      requestState.request.status == 'arrived') {
                    return ArriveView();
                  } else {
                    // return ArriveView();
                    return OnTransitPage();
                  }
                } else {
                  Future.delayed(Duration(seconds: 5), () {
                    context
                        .bloc<RequestsBloc>()
                        .add(StartListenOnCurrentRide(state.client.ride_id));
                  });
                  return Center(
                    child: Text('Fetching current ride details'),
                  );
                }
              },
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
