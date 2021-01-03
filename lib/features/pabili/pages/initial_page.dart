import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../core/Flavor.dart';
import '../../../core/client_bloc/client_bloc.dart';
import '../../../core/pabili_delivery/pabili_delivery_bloc.dart';
import '../../ride_sharing/widgets/map_bottom_sheet.dart';
import 'stores_listing_page.dart';

class InitialPabiliPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Provider.of<Flavor>(context) == Flavor.dev
            ? true
            : FirebaseAuth.instance.currentUser.emailVerified)
        ? BlocBuilder<ClientBloc, ClientState>(
            buildWhen: (prevState, newState) {
              if (prevState is ClientLoaded && newState is ClientLoaded) {
                return prevState.client.delivery_status !=
                    newState.client.delivery_status;
              }
              return true;
            },
            builder: (context, state) {
              if (state is ClientLoaded) {
                if (state.client.delivery_status == 'idle' ||
                    state.client.delivery_status == null) {
                  return StoresListingPage();
                } else if (state.client.delivery_status == 'requesting') {
                  return DeliveryRequestPage();
                } else {
                  return BlocBuilder<PabiliDeliveryBloc, PabiliDeliveryState>(
                    builder: (context, requestState) {
                      if (requestState is PabiliDeliveryLoaded) {
                        if (requestState.request.status == 'arriving' ||
                            requestState.request.status == 'arrived') {
                          return DeliveryArrivePage();
                        } else {
                          return DeliveryOnTransitPage();
                        }
                      } else {
                        Future.delayed(Duration(seconds: 5), () {
                          context.bloc<PabiliDeliveryBloc>().add(
                              StartListenOnPabiliRide(
                                  state.client.delivery_id));
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
          )
        : Scaffold(
            body: Center(
              child: Text(
                'To use our food delivery service,\nplease verify your email first.',
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}

class DeliveryRequestPage extends StatefulWidget {
  @override
  _DeliveryRequestPageState createState() => _DeliveryRequestPageState();
}

class _DeliveryRequestPageState extends State<DeliveryRequestPage> {
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
          return BlocBuilder<PabiliDeliveryBloc, PabiliDeliveryState>(
            builder: (rideContext, rideState) {
              if (rideState is PabiliDeliveryLoaded) {
                Future.delayed(Duration(seconds: 3), () {
                  context
                      .bloc<PabiliDeliveryBloc>()
                      .add(StartListenOnPabiliRide(state.client.delivery_id));
                });

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
                                        'Finding you a driver',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22.0),
                                      ),
                                      Text(
                                        '${rideState.request.pickup.place} - ${rideState.request.destination.address}',
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
                                        ClientCancelRide(
                                            state.client.delivery_id));
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
                      .bloc<PabiliDeliveryBloc>()
                      .add(StartListenOnPabiliRide(state.client.delivery_id));
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

class DeliveryArrivePage extends StatefulWidget {
  @override
  _DeliveryArrivePageState createState() => _DeliveryArrivePageState();
}

class _DeliveryArrivePageState extends State<DeliveryArrivePage> {
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
          return BlocBuilder<PabiliDeliveryBloc, PabiliDeliveryState>(
              builder: (context, requestState) {
            if (requestState is PabiliDeliveryLoaded) {
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
                          headerText: 'Driver is arriving at the restaurant.',
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
                          headerText: 'Driver fetching your order.',
                          subtitleWidget: SizedBox(
                            height: 27.5,
                          ),
                          request: requestState.request,
                          ride_id: clientState.client.delivery_id,
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
            } else {
              return Center(child: CircularProgressIndicator());
            }
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

class DeliveryOnTransitPage extends StatefulWidget {
  @override
  _DeliveryOnTransitPageState createState() => _DeliveryOnTransitPageState();
}

class _DeliveryOnTransitPageState extends State<DeliveryOnTransitPage> {
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
          return BlocBuilder<PabiliDeliveryBloc, PabiliDeliveryState>(
              builder: (context, requestState) {
            if (requestState is PabiliDeliveryLoaded) {
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
                    headerText: 'On the way to your location.',
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
                      ),
                      Marker(
                        markerId: MarkerId('destination'),
                        position: _destinationPoint,
                        icon: pinLocationIcon,
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
