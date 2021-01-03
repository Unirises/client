import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../core/client_bloc/client_bloc.dart';
import '../../core/requests_bloc/requests_bloc.dart';
import 'widgets/map_bottom_sheet.dart';

class OnTransitPage extends StatefulWidget {
  @override
  _OnTransitPageState createState() => _OnTransitPageState();
}

class _OnTransitPageState extends State<OnTransitPage> {
  Completer<GoogleMapController> _controller = Completer();
  final polyLines = PolylinePoints();

  GoogleMapController mapController;

  BitmapDescriptor pinLocationIcon;

  BitmapDescriptor car2SeaterIcon;

  BitmapDescriptor car4SeaterIcon;

  BitmapDescriptor car7SeaterIcon;

  BitmapDescriptor motorcycleIcon;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/rideshare-icons/home-pin.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/rideshare-icons/car2Seater.png')
        .then((value) {
      car2SeaterIcon = value;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/rideshare-icons/car4Seater.png')
        .then((value) {
      car4SeaterIcon = value;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/rideshare-icons/van.png')
        .then((value) {
      car7SeaterIcon = value;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/rideshare-icons/motorcycle.png')
        .then((value) {
      motorcycleIcon = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, clientState) {
        if (clientState is ClientLoaded) {
          return BlocBuilder<RequestsBloc, RequestsState>(
              builder: (context, requestState) {
            if (requestState is CurrentRideLoaded) {
              final _pickupPoint = LatLng(
                requestState.request.pickup.latitude,
                requestState.request.pickup.longitude,
              );
              final _destinationPoint = LatLng(
                requestState.request.destination.latitude,
                requestState.request.destination.longitude,
              );
              final _riderLocation = LatLng(
                requestState.request.position.latitude,
                requestState.request.position.longitude,
              );
              final listOfLatLng = polyLines
                  .decodePolyline(requestState.request.encodedPolyline)
                  .map((e) => LatLng(e.latitude, e.longitude))
                  .toList();

              final bounds = LatLngBounds(
                southwest: LatLng(
                  requestState.request.bounds['southwest']['lat'],
                  requestState.request.bounds['southwest']['lng'],
                ),
                northeast: LatLng(
                  requestState.request.bounds['northeast']['lat'],
                  requestState.request.bounds['northeast']['lng'],
                ),
              );
              // Animate Camera
              CameraUpdate u2 = CameraUpdate.newLatLngBounds(bounds, 75);
              mapController?.animateCamera(u2);

              return Scaffold(
                body: SlidingUpPanel(
                  panel: MapBottomSheet(
                    headerText: 'On the way to destination',
                    subtitleWidget: SizedBox(
                      height: 27.5,
                    ),
                    request: requestState.request,
                    ride_id: requestState.request.id,
                    leadingTitle: 'Completed',
                    leadingAction: 'completed',
                  ),
                  body: GoogleMap(
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
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
                      Marker(
                        markerId: MarkerId('driver'),
                        position: _riderLocation,
                        rotation: requestState.request.position.heading,
                        icon:
                            getIconBasedOnType(requestState.request.ride_type),
                      ),
                      Marker(
                        markerId: MarkerId('driver'),
                        position: _riderLocation,
                        rotation: requestState.request.position.heading,
                        icon:
                            getIconBasedOnType(requestState.request.ride_type),
                      ),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                      _controller.complete(controller);
                      CameraUpdate u2 =
                          CameraUpdate.newLatLngBounds(bounds, 75);
                      this.mapController.animateCamera(u2);
                    },
                    initialCameraPosition:
                        CameraPosition(target: _pickupPoint, zoom: 16),
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  BitmapDescriptor getIconBasedOnType(String type) {
    switch (type) {
      case 'car2Seater':
        return car2SeaterIcon;
        break;
      case 'car4Seater':
        return car4SeaterIcon;
        break;
      case 'car7Seater':
        return car7SeaterIcon;
        break;
      case 'motorcycle':
        return motorcycleIcon;
        break;
      default:
        return car2SeaterIcon;
        break;
    }
  }
}
