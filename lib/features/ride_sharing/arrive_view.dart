import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../core/client_bloc/client_bloc.dart';
import '../../core/requests_bloc/requests_bloc.dart';
import 'widgets/map_bottom_sheet.dart';

class ArriveView extends StatefulWidget {
  @override
  _ArriveViewState createState() => _ArriveViewState();
}

class _ArriveViewState extends State<ArriveView> {
  GoogleMapController mapController;
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor car2SeaterIcon;
  BitmapDescriptor car4SeaterIcon;
  BitmapDescriptor car7SeaterIcon;
  BitmapDescriptor motorcycleIcon;

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

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
              final _riderLocation = LatLng(
                requestState.request.position.latitude,
                requestState.request.position.longitude,
              );
              _getPolyline(_riderLocation, _pickupPoint);
              return Scaffold(
                body: SlidingUpPanel(
                  panel: (requestState.request.status == 'arriving')
                      ? MapBottomSheet(
                          headerText: 'Driver is arriving at your location.',
                          subtitleWidget: SizedBox(
                            height: 27.5,
                            child: Text(''),
                          ),
                          request: requestState.request,
                          ride_id: requestState.request.id,
                          leadingTitle: 'Arrived',
                          leadingAction: 'arrived',
                        )
                      : MapBottomSheet(
                          headerText: 'Driver is picking you up.',
                          subtitleWidget: SizedBox(
                            height: 27.5,
                          ),
                          request: requestState.request,
                          ride_id: clientState.client.ride_id,
                          leadingTitle: 'Start Trip',
                          leadingAction: 'transit',
                        ),
                  body: GoogleMap(
                    polylines: Set<Polyline>.of(polylines.values),
                    markers: {
                      Marker(
                        markerId: MarkerId('pickup'),
                        position: _pickupPoint,
                        icon: pinLocationIcon,
                      ),
                      Marker(
                        markerId: MarkerId('driver'),
                        position: _riderLocation,
                        rotation: requestState.request.position.heading,
                        icon:
                            getIconBasedOnType(requestState.request.ride_type),
                      ),
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

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    mapController.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline(LatLng _driverPos, LatLng _destPos) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBWlDJm4CJ_PAhhrC0F3powcfmy_NJEn2E',
      PointLatLng(_driverPos.latitude, _driverPos.longitude),
      PointLatLng(_destPos.latitude, _driverPos.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      polylineCoordinates = [];
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
