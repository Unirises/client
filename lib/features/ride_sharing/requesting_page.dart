import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/client_bloc/client_bloc.dart';
import '../../core/ride_sharing_bloc/ride_sharing_bloc.dart';

class RequestingPage extends StatefulWidget {
  @override
  _RequestingPageState createState() => _RequestingPageState();
}

class _RequestingPageState extends State<RequestingPage> {
  final polyLines = PolylinePoints();

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/rideshare-icons/home-pin.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        if (state is ClientLoaded) {
          return BlocBuilder<RideSharingBloc, RideSharingState>(
            builder: (rideContext, rideState) {
              if (rideState is RideSharingLoaded) {
                final _pickupPoint = LatLng(
                  rideState.request.pickup.latitude,
                  rideState.request.pickup.longitude,
                );
                final _destinationPoint = LatLng(
                  rideState.request.destination.latitude,
                  rideState.request.destination.longitude,
                );

                final listOfLatLng = polyLines
                    .decodePolyline(rideState.request.encodedPolyline)
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList();

                final bounds = LatLngBounds(
                  southwest: LatLng(
                    rideState.request.bounds['southwest']['lat'],
                    rideState.request.bounds['southwest']['lng'],
                  ),
                  northeast: LatLng(
                    rideState.request.bounds['northeast']['lat'],
                    rideState.request.bounds['northeast']['lng'],
                  ),
                );

                // Animate Camera
                CameraUpdate u2 = CameraUpdate.newLatLngBounds(bounds, 75);
                mapController?.animateCamera(u2);

                return Scaffold(
                  body: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: GoogleMap(
                              zoomControlsEnabled: false,
                              polylines: {
                                Polyline(
                                  polylineId: PolylineId('routeToEnd'),
                                  points: listOfLatLng,
                                  endCap: Cap.roundCap,
                                  startCap: Cap.roundCap,
                                  color: Theme.of(context).primaryColor,
                                )
                              },
                              markers: {
                                Marker(
                                  markerId: MarkerId('pickup'),
                                  position: _pickupPoint,
                                  icon: pinLocationIcon,
                                ),
                                Marker(
                                  markerId: MarkerId('destination'),
                                  position: _destinationPoint,
                                ),
                              },
                              onMapCreated: (GoogleMapController controller) {
                                mapController = controller;
                                _controller.complete(controller);
                                CameraUpdate u2 =
                                    CameraUpdate.newLatLngBounds(bounds, 75);
                                this.mapController.animateCamera(u2);
                              },
                              initialCameraPosition: CameraPosition(
                                  target: _pickupPoint, zoom: 14),
                            ),
                          ),
                          SizedBox(
                            height: 135,
                          )
                        ],
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 15.0, // soften the shadow
                                spreadRadius: 0.5, //extend the shadow
                                offset: Offset(
                                  0.7, // Move to right 10  horizontally
                                  0.7, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                          ),
                          height: 195,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Requesting a Ride',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22.0),
                                      ),
                                      Text(
                                        '${rideState.request.pickup.address} - ${rideState.request.destination.address}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 11.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.bloc<ClientBloc>().add(
                                        ClientCancelRide(state.client.ride_id));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                              width: 1.0, color: Colors.grey),
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          size: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: Text(
                                          'Cancel ride',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                Future.delayed(Duration(seconds: 5), () {
                  context
                      .bloc<RideSharingBloc>()
                      .add(StartListenOnRide(state.client.ride_id));
                });
              }
              return Center(child: CircularProgressIndicator());
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
