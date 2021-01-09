import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/client_bloc/client_bloc.dart';
import '../../bloc/parcel_ride_bloc.dart';

class ParcelRequestingPage extends StatefulWidget {
  @override
  _ParcelRequestingPageState createState() => _ParcelRequestingPageState();
}

class _ParcelRequestingPageState extends State<ParcelRequestingPage> {
  final polyLines = PolylinePoints();
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParcelRideBloc, ParcelRideState>(
      builder: (context, state) {
        if (state is ParcelRideInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ParcelRideFailure) {
          return Center(
            child: Text('There was a problem loading your data.'),
          );
        } else if (state is ParcelRideLoaded) {
          final bounds = LatLngBounds(
            southwest: LatLng(
              state.request.directions.routes.first.bounds.southwest.lat,
              state.request.directions.routes.first.bounds.southwest.lng,
            ),
            northeast: LatLng(
              state.request.directions.routes.first.bounds.northeast.lat,
              state.request.directions.routes.first.bounds.northeast.lng,
            ),
          );
          final listOfLatLng = polyLines
              .decodePolyline(
                  state.request.directions.routes.first.overviewPolyline.points)
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList();
          final Set<Marker> markers = {};

          markers.add(Marker(
              markerId: MarkerId('start'),
              position: LatLng(state.request.pickup.location.lat,
                  state.request.pickup.location.lng),
              infoWindow: InfoWindow(title: 'Start')));

          for (var i = 0; i < state.request.points.length; i++) {
            markers.add(Marker(
                markerId: MarkerId(String.fromCharCode(i)),
                position: LatLng(state.request.points[i].location.lat,
                    state.request.points[i].location.lng),
                infoWindow: InfoWindow(title: state.request.points[i].name)));
          }

          CameraUpdate u2 = CameraUpdate.newLatLngBounds(bounds, 75);
          mapController?.animateCamera(u2);

          return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: GoogleMap(
                        cameraTargetBounds: CameraTargetBounds(bounds),
                        initialCameraPosition:
                            CameraPosition(target: LatLng(0, 0), zoom: 18),
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                          _controller.complete(controller);
                          CameraUpdate u2 =
                              CameraUpdate.newLatLngBounds(bounds, 75);
                          this.mapController.animateCamera(u2);
                        },
                        polylines: {
                          Polyline(
                            polylineId: PolylineId('routeToEnd'),
                            points: listOfLatLng,
                            endCap: Cap.roundCap,
                            startCap: Cap.roundCap,
                            color: Theme.of(context).primaryColor,
                          )
                        },
                        markers: markers,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 18),
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
                                  'Requesting a Parcel Delivery',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22.0),
                                ),
                                Text(
                                  'Pick-up at: ${state.request.pickup.address}',
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
                              context.bloc<ClientBloc>().add(ClientCancelRide(
                                  (context.read<ClientBloc>().state
                                          as ClientLoaded)
                                      .client
                                      .ride_id));
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
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
        }
        return Container();
      },
    );
  }
}
