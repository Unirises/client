import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/client_bloc/client_bloc.dart';
import '../../bloc/parcel_bloc.dart';
import '../../bloc/parcel_ride_bloc.dart';
import '../state_pages/parcel_pickup_page.dart';
import '../state_pages/parcel_requesting_page.dart';
import 'parcel_initial_page.dart';

class PabiliMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParcelBloc, ParcelState>(
      builder: (context, state) {
        if (state is ParcelLoadFailure) {
          return Center(
            child: Text(
                'There was a trouble processing parcel data. Please try again.'),
          );
        } else if (state is ParcelLoadSuccess) {
          return BlocBuilder<ClientBloc, ClientState>(
            builder: (context, clientState) {
              if (clientState is ClientInitial) {
                return Center(
                  child: Text('There was a problem accessing your user data.'),
                );
              } else {
                return BlocBuilder<ParcelRideBloc, ParcelRideState>(
                  builder: (context, rideState) {
                    if (clientState is ClientLoaded) {
                      if (clientState.client.status == 'idle') {
                        return ParcelInitialPage();
                      } else {
                        if (rideState is ParcelRideInitial) {
                          Future.delayed(Duration(seconds: 5), () {
                            context.read<ParcelRideBloc>().add(
                                StartListenOnParcelRide(
                                    clientState.client.ride_id));
                          });
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (rideState is ParcelRideLoaded) {
                          if (clientState.client.status == 'requesting') {
                            return ParcelRequestingPage();
                          } else if (clientState.client.status == 'transit') {
                            return ParcelPickupPage();
                          } else if (clientState.client.status == 'arrived') {
                            return ParcelPickupPage();
                          } else if (clientState.client.status == 'arriving') {
                            return ParcelPickupPage();
                          } else if (clientState.client.status == 'cancelled' ||
                              clientState.client.status == 'completed') {
                            return Center(
                              child: Text(
                                  'This ride is already cancelled/completed. Please wait or refresh app to reflect changes.'),
                            );
                          }
                        } else {
                          return Center(
                            child: Text(
                                'There was a trouble processing parcel data. Please try again.'),
                          );
                        }
                      }
                    }
                    return Container();
                  },
                );
              }
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
