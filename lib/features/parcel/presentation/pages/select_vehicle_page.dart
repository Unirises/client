import 'dart:async';

import 'package:client/features/parcel/bloc/parcel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectVehiclePage extends StatefulWidget {
  final Function(String) onSelected;

  const SelectVehiclePage({Key key, this.onSelected}) : super(key: key);

  @override
  _SelectVehiclePageState createState() => _SelectVehiclePageState();
}

class _SelectVehiclePageState extends State<SelectVehiclePage> {
  final polyLines = PolylinePoints();
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  String selected = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParcelBloc, ParcelState>(
      builder: (context, state) {
        if (state is ParcelLoadingInProgress) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ParcelLoadFailure) {
          return Scaffold(
            body: Center(
              child: Text('There was a problem loading your data.'),
            ),
          );
        } else if (state is ParcelLoadSuccess) {
          final bounds = LatLngBounds(
            southwest: LatLng(
              state.directions.routes.first.bounds.southwest.lat,
              state.directions.routes.first.bounds.southwest.lng,
            ),
            northeast: LatLng(
              state.directions.routes.first.bounds.northeast.lat,
              state.directions.routes.first.bounds.northeast.lng,
            ),
          );
          final listOfLatLng = polyLines
              .decodePolyline(
                  state.directions.routes.first.overviewPolyline.points)
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList();
          CameraUpdate u2 = CameraUpdate.newLatLngBounds(bounds, 45);
          mapController?.animateCamera(u2);
          return Stack(
            children: [
              GoogleMap(
                cameraTargetBounds: CameraTargetBounds(bounds),
                initialCameraPosition:
                    CameraPosition(target: LatLng(0, 0), zoom: 18),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  _controller.complete(controller);
                  CameraUpdate u2 = CameraUpdate.newLatLngBounds(bounds, 45);
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
              ),
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: RaisedButton(
                              onPressed: (selected != null && selected != '')
                                  ? widget.onSelected(selected)
                                  : null,
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: Text('Select Vehicle'),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          );
        } else {
          return Text('Unknown state: ${state}');
        }
      },
    );
  }
}
