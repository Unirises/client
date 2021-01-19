import 'dart:async';
import 'dart:io';

import 'package:client/core/client_bloc/client_bloc.dart';
import 'package:client/features/parcel/built_models/built_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/Request.dart';

class TransactionPage extends StatelessWidget {
  final BuiltRequest ride;

  const TransactionPage({Key key, this.ride})
      : assert(ride != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}

// class TransactionPage extends StatefulWidget {
//   final Request request;

//   const TransactionPage({Key key, this.request}) : super(key: key);

//   @override
//   _TransactionPageState createState() => _TransactionPageState();
// }

// class _TransactionPageState extends State<TransactionPage> {
//   final polyLines = PolylinePoints();
//   Completer<GoogleMapController> _controller = Completer();
//   GoogleMapController mapController;
//   File payment;

//   @override
//   Widget build(BuildContext context) {
//     final bounds = LatLngBounds(
//       southwest: LatLng(
//         widget.request.bounds['southwest']['lat'],
//         widget.request.bounds['southwest']['lng'],
//       ),
//       northeast: LatLng(
//         widget.request.bounds['northeast']['lat'],
//         widget.request.bounds['northeast']['lng'],
//       ),
//     );
//     final listOfLatLng = polyLines
//         .decodePolyline(widget.request.encodedPolyline)
//         .map((e) => LatLng(e.latitude, e.longitude))
//         .toList();

//     CameraUpdate u2 = CameraUpdate.newLatLngBounds(bounds, 45);
//     mapController?.animateCamera(u2);

//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Expanded(
//             child: GoogleMap(
//               cameraTargetBounds: CameraTargetBounds(bounds),
//               mapType: MapType.normal,
//               liteModeEnabled: false,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(
//                   widget.request.destination.latitude,
//                   widget.request.destination.longitude,
//                 ),
//                 zoom: 18,
//               ),
//               markers: {
//                 Marker(
//                   markerId: MarkerId('pickup'),
//                   position: LatLng(
//                     widget.request.pickup.latitude,
//                     widget.request.pickup.longitude,
//                   ),
//                 ),
//                 Marker(
//                   markerId: MarkerId('dropoff'),
//                   position: LatLng(
//                     widget.request.destination.latitude,
//                     widget.request.destination.longitude,
//                   ),
//                 ),
//               },
//               onMapCreated: (GoogleMapController controller) {
//                 mapController = controller;
//                 _controller.complete(controller);
//                 CameraUpdate u2 = CameraUpdate.newLatLngBounds(bounds, 45);
//                 this.mapController.animateCamera(u2);
//               },
//               polylines: {
//                 Polyline(
//                   polylineId: PolylineId('routeToEnd'),
//                   points: listOfLatLng,
//                   endCap: Cap.roundCap,
//                   startCap: Cap.roundCap,
//                   color: Theme.of(context).primaryColor,
//                 )
//               },
//             ),
//           ),
//           Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                           child: Text(
//                             'Driver Details',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '${widget.request.driverName}',
//                                 style: const TextStyle(color: Colors.grey),
//                               ),
//                               GestureDetector(
//                                 onTap: () async {
//                                   await launch(
//                                       'tel:${widget.request.driverNumber}');
//                                 },
//                                 child: Text(
//                                   '${widget.request.clientNumber}',
//                                   style: const TextStyle(
//                                       color: Colors.blueGrey,
//                                       decoration: TextDecoration.underline),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                           child: Text(
//                             'Pickup Point',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             '${widget.request.pickup.place != null ? widget.request.pickup.place + ' - ' + widget.request.pickup.address : widget.request.pickup.address}',
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                           child: Text(
//                             'Destination Point',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             '${widget.request.destination.place != null ? widget.request.destination.place + ' - ' + widget.request.destination.address : widget.request.destination.address}',
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     buildPrices(),
//                     const SizedBox(height: 12),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                           child: Text(
//                             'Distance Travelled',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             '${(widget.request.distance / 1000).round()} km',
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                           child: Text(
//                             'Travel Time',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             '${(widget.request.duration / 60).round()} minutes',
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ),
//                       ],
//                     ),
//                     // const SizedBox(height: 12),
//                     // Row(
//                     //   crossAxisAlignment: CrossAxisAlignment.start,
//                     //   children: [
//                     //     const Expanded(
//                     //       child: Text(
//                     //         'Payment Method',
//                     //         style: TextStyle(fontWeight: FontWeight.bold),
//                     //       ),
//                     //     ),
//                     //     Expanded(
//                     //       flex: 2,
//                     //       child: Text(
//                     //         'cash',
//                     //         style: const TextStyle(color: Colors.grey),
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//                     const SizedBox(height: 12),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                           child: Text(
//                             'Request Created',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             '${DateFormat('E, d y h:mm a').format(DateTime.fromMillisecondsSinceEpoch(widget.request.timestamp))}',
//                             style: const TextStyle(color: Colors.grey),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget buildPrices() {
//     if (widget.request.isFoodDelivery) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Expanded(
//                 child: Text(
//                   'Order Subtotal',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Text(
//                   'PHP ${widget.request.data['subtotal']}',
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Expanded(
//                 child: Text(
//                   'Total',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Text(
//                   'PHP ${widget.request.price}',
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
//     }
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Expanded(
//           child: Text(
//             'Fare',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: Text(
//             'PHP ${widget.request.price.toStringAsFixed(2)}',
//             style: const TextStyle(color: Colors.grey),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildisChargePaid(String isChargePaid) {
//     switch (isChargePaid) {
//       case 'false':
//         return Text(
//           'Not Yet',
//           style: TextStyle(color: Colors.red),
//         );
//         break;
//       case 'true':
//         return Text(
//           'Paid',
//           style: TextStyle(color: Colors.green),
//         );
//         break;
//       default:
//         return Text(
//           'Awaiting',
//           style: TextStyle(color: Colors.yellow),
//         );
//         break;
//     }
//   }
// }
