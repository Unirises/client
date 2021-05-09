import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../parcel/built_models/built_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionPage extends StatefulWidget {
  final BuiltRequest ride;

  const TransactionPage({Key? key, required this.ride}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final polyLines = PolylinePoints();
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    final listOfLatLng = polyLines
        .decodePolyline(
            widget.ride.directions!.routes!.first.overviewPolyline!.points!)
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
    var bounds = LatLngBounds(
      northeast: LatLng(
        widget.ride.directions!.routes!.first.bounds!.northeast!.lat!,
        widget.ride.directions!.routes!.first.bounds!.northeast!.lng!,
      ),
      southwest: LatLng(
        widget.ride.directions!.routes!.first.bounds!.southwest!.lat!,
        widget.ride.directions!.routes!.first.bounds!.southwest!.lng!,
      ),
    );

    final Set<Marker> markers = {};

    for (var i = 0; i < widget.ride.points!.length; i++) {
      markers.add(Marker(
          markerId: MarkerId(String.fromCharCode(i)),
          position: LatLng(widget.ride.points![i].location!.lat!,
              widget.ride.points![i].location!.lng!),
          infoWindow: InfoWindow(title: widget.ride.points![i].name)));
    }

    markers.add(Marker(
        markerId: MarkerId('Pickup'),
        position: LatLng(widget.ride.pickup!.location!.lat!,
            widget.ride.pickup!.location!.lng!),
        infoWindow: InfoWindow(title: 'Pickup')));
    !widget.ride.isParcel!
        ? markers.add(Marker(
            markerId: MarkerId('Destination'),
            position: LatLng(widget.ride.destination!.location!.lat!,
                widget.ride.destination!.location!.lng!),
            infoWindow: InfoWindow(title: 'Destination')))
        : null;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              cameraTargetBounds: CameraTargetBounds(bounds),
              mapType: MapType.normal,
              liteModeEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  widget.ride.pickup!.location!.lat!,
                  widget.ride.pickup!.location!.lng!,
                ),
                zoom: 18,
              ),
              markers: markers,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                _controller.complete(controller);
                Future.delayed(const Duration(milliseconds: 100), () {
                  CameraUpdate u2 = CameraUpdate.newLatLngBounds(bounds, 45);
                  this.mapController.animateCamera(u2);
                });
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
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (widget.ride.driverId != null)
                            ? const Expanded(
                                child: Text(
                                  'Driver Details',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            : Container(),
                        (widget.ride.driverId != null)
                            ? Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.ride.driverName}',
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await launch(
                                            'tel:${widget.ride.driverNumber}');
                                      },
                                      child: Text(
                                        '${widget.ride.driverNumber}',
                                        style: const TextStyle(
                                            color: Colors.blueGrey,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            'Pickup Point',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${widget.ride.isParcel! ? widget.ride.pickup!.address : widget.ride.pickup!.name! + ' - ' + widget.ride.pickup!.address!}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            'Destination Point',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${widget.ride.isParcel! ? widget.ride.points!.last.name! + ' - ' + widget.ride.points!.last.address! : widget.ride.destination!.address}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    buildPrices(),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            'Timestamp',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${DateFormat('E, d y h:mm a').format(DateTime.fromMillisecondsSinceEpoch(widget.ride.timestamp as int))}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            'Type',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.ride.isParcel!
                                ? 'Parcel Delivery'
                                : 'Merchants',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.ride.status!.capitalizeFirstofEach,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    (widget.ride.driverId != null)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              const Text(
                                'Rating',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SmoothStarRating(
                                  allowHalfRating: false,
                                  onRated: (v) async {
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection('clients')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection('rides')
                                          .doc(widget.ride.id)
                                          .update({'rating': v});
                                    } catch (e, st) {
                                      await FirebaseCrashlytics.instance
                                          .recordError(
                                        e,
                                        st,
                                        reason: 'Cannot update rating',
                                      );
                                      Flushbar(
                                        title: 'Rating Failure',
                                        message:
                                            'Sorry we cannot update your request at the moment.',
                                        duration: Duration(seconds: 5),
                                      )..show(context);
                                      return null;
                                    }

                                    if (widget.ride.id == null) return null;

                                    try {
                                      await FirebaseFirestore.instance
                                          .collection('drivers')
                                          .doc(widget.ride.driverId)
                                          .collection('rides')
                                          .doc(widget.ride.id)
                                          .update({'rating': v});

                                      Flushbar(
                                        title: 'Rating Success',
                                        message:
                                            'Your rating has been updated successfully. To see updates, please refresh page.',
                                        duration: Duration(seconds: 5),
                                      )..show(context);
                                      return null;
                                    } catch (e, st) {
                                      await FirebaseCrashlytics.instance
                                          .recordError(
                                        e,
                                        st,
                                        reason: 'Cannot update rating',
                                      );
                                      Flushbar(
                                        title: 'Rating Failure',
                                        message:
                                            'Sorry, driver data cannot handle your request at the moment.',
                                        duration: Duration(seconds: 5),
                                      )..show(context);
                                      return null;
                                    }
                                  },
                                  starCount: 5,
                                  rating: widget.ride.rating!.toDouble(),
                                  size: 40.0,
                                  color: Theme.of(context).primaryColor,
                                  borderColor: Color(0xff424242),
                                  spacing: 0.0)
                            ],
                          )
                        : Container(),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget buildPrices() {
    if (!widget.ride.isParcel!) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Order Subtotal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'PHP ${widget.ride.subtotal!.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Delivery Fee',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'PHP ${widget.ride.fee!.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'PHP ${(widget.ride.fee! + widget.ride.subtotal!).toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Text(
            'Delivery Fee',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'PHP ${widget.ride.fee!.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.inCaps).join(" ");
}
