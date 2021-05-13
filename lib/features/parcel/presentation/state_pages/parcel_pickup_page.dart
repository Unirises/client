import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widgets/profile_picture.dart';
import '../../bloc/parcel_ride_bloc.dart';
import '../../built_models/built_stop.dart';

class ParcelPickupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = (context.watch<ParcelRideBloc>().state as ParcelRideLoaded);

    BuiltStop? dest;

    if (state.request!.currentIndex == 0) {
      dest = state.request!.pickup;
    } else if (state.request!.currentIndex! >= 1) {
      dest = state.request!.points![state.request!.currentIndex! - 1];
    }

    var listOflatLng = PolylinePoints()
        .decodePolyline(
            state.request!.directions!.routes!.first.overviewPolyline!.points!)
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
    var now =
        DateTime.fromMillisecondsSinceEpoch(state.request!.timestamp as int);
    now = now.add(Duration(minutes: 3));
    var optimistic = DateFormat('hh:mm a').format(now.add(Duration(
        seconds: (dest!.duration != null) ? dest.duration!.value! : 1500)));
    var pessmistic = DateFormat('hh:mm a').format(now
        .add(Duration(
            seconds: (dest.duration != null) ? dest.duration!.value! : 1500))
        .add(Duration(minutes: 35)));
    return Stack(
      children: [
        GoogleMap(
          markers: state.request != null
              ? {
                  Marker(
                      rotation: state.request!.position!.heading!.toDouble(),
                      markerId: MarkerId('yourCurrentLocation'),
                      infoWindow: InfoWindow(title: 'Driver Location'),
                      icon: state.carImage!,
                      position: LatLng(
                        state.request!.position!.latitude as double,
                        state.request!.position!.longitude as double,
                      )),
                  Marker(
                      markerId: MarkerId('destination'),
                      infoWindow: InfoWindow(title: 'Destination'),
                      position: LatLng(
                        dest.location!.lat,
                        dest.location!.lng,
                      )),
                }
              : {},
          polylines: {
            Polyline(
              polylineId: PolylineId('routeToEnd'),
              points: listOflatLng,
              endCap: Cap.roundCap,
              startCap: Cap.roundCap,
              color: Theme.of(context).primaryColor,
            )
          },
          cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            northeast: LatLng(
                state
                    .request!.directions!.routes!.first.bounds!.northeast!.lat!,
                state.request!.directions!.routes!.first.bounds!.northeast!
                    .lng!),
            southwest: LatLng(
                state
                    .request!.directions!.routes!.first.bounds!.southwest!.lat!,
                state.request!.directions!.routes!.first.bounds!.southwest!
                    .lng!),
          )),
          initialCameraPosition: CameraPosition(
            target: LatLng(state.request!.position!.latitude as double,
                state.request!.position!.longitude as double),
            zoom: 18,
          ),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
        ),
        DraggableScrollableSheet(builder: (context, controller) {
          return SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Estimated parcel arrival time'),
                        Text(
                          '$optimistic - $pessmistic',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Divider(),
                        Text(
                          '${state.request!.status == 'arriving' ? 'Arriving to ' + dest!.name! : state.request!.status == 'transit' ? 'Sending Parcel to ' + dest!.name! : 'Arrived at ' + dest!.name!}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                            '${state.request!.status == 'arriving' ? 'The driver is on the way to the pickup/recepient.' : state.request!.status == 'transit' ? 'The driver is sending your parcel to the receiver.' : 'The driver has arrived.'}'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ProfilePictureWidget(
                              radius: 30,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.request!.driverName ??
                                        'No Driver Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(children: [
                                    Text(state.request!.vehicleData!.brand! +
                                        ' '),
                                    Text(state.request!.vehicleData!.model! +
                                        ' '),
                                    Text(state.request!.vehicleData!.color! +
                                        ' '),
                                    Text(' - '),
                                    Text(state.request!.vehicleData!.plate!)
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Divider(),
                        IconButton(
                            onPressed: () async =>
                                launch('tel:${state.request!.driverNumber}'),
                            icon: Icon(Icons.call)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Parcel Delivery for ${state.request!.pickup!.name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total'),
                            Text(
                              'PHP ${state.request!.fee!.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18, right: 18, bottom: 18),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: Text('${state.request!.pickup!.address}')),
                        ]),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(),
                        Row(children: [
                          Icon(Icons.pin_drop),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              child: Text(
                                  '${dest == state.request!.pickup ? state.request!.points![0].address : dest.address}')),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        })
      ],
    );
  }
}
