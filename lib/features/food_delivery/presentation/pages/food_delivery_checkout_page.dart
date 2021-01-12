import 'dart:async';
import 'dart:developer';

import 'package:client/features/food_delivery/bloc/checkout_bloc.dart';
import 'package:client/features/parcel/presentation/pages/add_stop_details_page.dart';
import 'package:client/features/parcel/presentation/pages/select_vehicle_page.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FoodDeliveryCheckoutPage extends StatelessWidget {
  final Function onBooked;

  const FoodDeliveryCheckoutPage({Key key, this.onBooked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
      if (state is CheckoutLoadingInProgress) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is CheckoutLoadFailure) {
        return Scaffold(
          body: Center(
            child: Text(
                'There has been a problem processing merchant and checkout data.'),
          ),
        );
      } else if (state is CheckoutLoadSuccess) {
        List<num> items = [];
        num subtotal = 0.00;

        state.items.forEach((item) {
          var tmp = 0;
          tmp += item.additionalPrice;
          tmp += item.itemPrice;
          tmp *= item.quantity;
          items.add(tmp);
        });

        if (items.length > 0) {
          subtotal = items.reduce((value, element) => value + element);
        }

        return Scaffold(
            appBar: AppBar(
              title: Column(
                children: [
                  Text(state.merchant.companyName),
                  (state.destination != null &&
                          state.destination.duration != null)
                      ? RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    'Distance from you: ${(state.destination.distance / 1000).toStringAsFixed(2)} km'),
                            TextSpan(
                                text: ' (${state.destination.duration.text})'),
                          ]),
                        )
                      : Container(),
                ],
              ),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 140,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              (state.destination != null)
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      padding: EdgeInsets.all(24),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 48,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(state.destination.name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 18,
                                                    )),
                                                Text(state.destination.address),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),
                              Row(children: [
                                Expanded(
                                  child: RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    textColor: Colors.white,
                                    child: Text('Select Location'),
                                    onPressed: () async {
                                      LocationResult result =
                                          await showLocationPicker(
                                        context,
                                        'AIzaSyAt9lUp_riyazE0ZgeSPya-HPtiWBxkMiU',
                                        initialCenter:
                                            LatLng(14.6091, 121.0223),
                                        automaticallyAnimateToCurrentLocation:
                                            true,
                                        myLocationButtonEnabled: true,
                                        requiredGPS: true,
                                        countries: ['PH'],
                                        desiredAccuracy: LocationAccuracy.best,
                                      );
                                      if (result == null ||
                                          result.address == null) return;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddStopDetailsPage(
                                                  location: result,
                                                  isPickup: true,
                                                  onSubmitFinished: (data) {
                                                    Navigator.pop(context);
                                                    context
                                                        .bloc<CheckoutBloc>()
                                                        .add(
                                                            CheckoutDestinationUpdated(
                                                                data));
                                                  },
                                                  onCancelled: () {
                                                    Navigator.pop(context);
                                                    return Flushbar(
                                                      title: 'Event cancelled',
                                                      message:
                                                          'You cancelled adding destination to your request.',
                                                      duration:
                                                          Duration(seconds: 5),
                                                      isDismissible: false,
                                                      showProgressIndicator:
                                                          true,
                                                      progressIndicatorBackgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      flushbarPosition:
                                                          FlushbarPosition.TOP,
                                                    )..show(context);
                                                  },
                                                )),
                                      );
                                    },
                                  ),
                                ),
                              ]),
                              Row(children: [
                                Expanded(
                                  child: RaisedButton(
                                    child: Text('Select Vehicle Type'),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FoodDeliverySelectVehicle(
                                            onSelected: (selected) {
                                              context.bloc<CheckoutBloc>().add(
                                                  CheckoutVehicleUpdated(
                                                      selectedVehicleType:
                                                          selected));
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('PHP ' + subtotal.toStringAsFixed(2))
                              ],
                            ),
                            (state.deliveryFee != null)
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Delivery Fee (${buildType(state.selectedVehicleType)})',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('PHP ' +
                                          state.deliveryFee.toStringAsFixed(2))
                                    ],
                                  )
                                : Container(),
                            (state.deliveryFee != null)
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('PHP ' +
                                          (subtotal + state.deliveryFee)
                                              .toStringAsFixed(2))
                                    ],
                                  )
                                : Container(),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 6,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(28)),
                          color: Colors.white),
                      child: GestureDetector(
                        onTap: (state.destination != null &&
                                state.directions != null)
                            ? (state.selectedVehicleType == null)
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FoodDeliverySelectVehicle(
                                          onSelected: (selected) {
                                            context.bloc<CheckoutBloc>().add(
                                                CheckoutVehicleUpdated(
                                                    selectedVehicleType:
                                                        selected));
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                : () {
                                    print('book ride');
                                    // context.bloc<ParcelBloc>().add(
                                    //       RequestParcel(
                                    //           type: selected,
                                    //           rideBloc: context.bloc<
                                    //               ParcelRideBloc>(),
                                    //           name: (context
                                    //                       .bloc<
                                    //                           UserCollectionBloc>()
                                    //                       .state
                                    //                   as UserCollectionLoaded)
                                    //               .userCollection
                                    //               .name,
                                    //           number: (context
                                    //                       .bloc<
                                    //                           UserCollectionBloc>()
                                    //                       .state
                                    //                   as UserCollectionLoaded)
                                    //               .userCollection
                                    //               .phone),
                                    //     );
                                    Navigator.pop(context);
                                  }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: (state.destination != null)
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            child: Center(
                              child: Text(
                                (state.selectedVehicleType == null)
                                    ? 'Select Vehicle'
                                    : 'Book Request',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            padding: const EdgeInsets.all(24),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ));
      }
    });
  }

  String buildType(String type) {
    switch (type) {
      case 'motorcycle':
        return 'Motorcycle';
      case 'car2Seater':
        return 'Sedan & SUV';
      case 'car4Seater':
        return 'Mini Van or MPV';
      case 'car7Seater':
        return 'Van';
      default:
        return 'Unknown type';
    }
  }
}

class FoodDeliverySelectVehicle extends StatefulWidget {
  final Function(String) onSelected;

  const FoodDeliverySelectVehicle({Key key, this.onSelected}) : super(key: key);

  @override
  _FoodDeliverySelectVehicleState createState() =>
      _FoodDeliverySelectVehicleState();
}

class _FoodDeliverySelectVehicleState extends State<FoodDeliverySelectVehicle> {
  final polyLines = PolylinePoints();
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  String selected = 'motorcycle';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state is CheckoutLoadingInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CheckoutLoadFailure) {
          return Center(
            child: Text(
                'There has been a problem processing merchant and checkout data.'),
          );
        } else if (state is CheckoutLoadSuccess) {
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

          markers.add(Marker(
              markerId: MarkerId('start'),
              position: LatLng(state.destination.location.lat,
                  state.destination.location.lng),
              infoWindow: InfoWindow(title: 'Destination')));
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
                            items: [
                              DropdownMenuItem<String>(
                                value: 'motorcycle',
                                child: Text('Motorcycle'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'car2Seater',
                                child: Text('Sedan & SUV'),
                                onTap: null,
                              ),
                              DropdownMenuItem<String>(
                                value: 'car4Seater',
                                child: Text('Mini Van or MPV'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'car7Seater',
                                child: Text('Van'),
                              ),
                            ],
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
                                child: Text('Select Vehicle'),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
