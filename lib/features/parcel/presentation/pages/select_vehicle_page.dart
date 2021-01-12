import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../bloc/parcel_bloc.dart';

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
  String selected = 'car7Seater';

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

          final Set<Marker> markers = {};

          markers.add(Marker(
              markerId: MarkerId('start'),
              position:
                  LatLng(state.pickup.location.lat, state.pickup.location.lng),
              infoWindow: InfoWindow(title: 'Start')));

          for (var i = 0; i < state.points.length; i++) {
            markers.add(Marker(
                markerId: MarkerId(String.fromCharCode(i)),
                position: LatLng(
                    state.points[i].location.lat, state.points[i].location.lng),
                infoWindow: InfoWindow(title: state.points[i].name)));
          }
          print(state.data);
          CameraUpdate u2 = CameraUpdate.newLatLngBounds(bounds, 45);
          mapController?.animateCamera(u2);
          return Scaffold(
            body: Stack(
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
                  markers: markers,
                ),
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Container(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          DropdownButton<String>(
                            value: selected,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            underline: Container(
                              height: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                selected = newValue;
                              });
                            },
                            items: buildDropdownItems(state.data),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: RaisedButton(
                                onPressed: (selected != '')
                                    ? () => widget.onSelected(selected)
                                    : null,
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                child: Text('Book Ride'),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          );
        } else {
          return Text('Unknown state: ${state}');
        }
      },
    );
  }

  List<DropdownMenuItem<String>> buildDropdownItems(Map<String, dynamic> data) {
    List<DropdownMenuItem<String>> list = [];

    if (data['weight'] <= 20) {
      list.add(DropdownMenuItem<String>(
        value: 'motorcycle',
        child: Text('Motorcycle'),
      ));
    }

    if (data['weight'] <= 300) {
      list.add(
        DropdownMenuItem<String>(
          value: 'car2Seater',
          child: Text('Sedan & SUV'),
          onTap: null,
        ),
      );
    }

    if (data['weight'] <= 600) {
      list.add(
        DropdownMenuItem<String>(
          value: 'car4Seater',
          child: Text('Mini Van or MPV'),
        ),
      );
    }

    if (data['weight'] <= 1000 || data['weight'] >= 1000) {
      list.add(
        DropdownMenuItem<String>(
          value: 'car7Seater',
          child: Text('Van'),
        ),
      );
    }

    return list;
  }
}
