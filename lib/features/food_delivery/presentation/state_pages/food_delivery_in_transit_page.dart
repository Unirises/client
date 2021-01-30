import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widgets/profile_picture.dart';
import '../../bloc/food_ride_bloc.dart';
import '../pages/see_more_details_page.dart';

class FoodDeliveryInTransitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = (context.watch<FoodRideBloc>().state as FoodRideLoaded);
    var listOflatLng = PolylinePoints()
        .decodePolyline(
            state.request.directions.routes.first.overviewPolyline.points)
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
    var now = DateTime.fromMillisecondsSinceEpoch(state.request.timestamp);
    now = now.add(Duration(
        minutes: (state.request.averageTimePreparation == null)
            ? 0
            : state.request.averageTimePreparation));
    now = now.add(Duration(minutes: 3));
    var optimistic = DateFormat('hh:mm a').format(
        now.add(Duration(seconds: state.request.destination.duration.value)));
    var pessmistic = DateFormat('hh:mm a').format(now
        .add(Duration(seconds: state.request.destination.duration.value))
        .add(Duration(minutes: 35)));
    return Stack(
      children: [
        GoogleMap(
          trafficEnabled: true,
          polylines: {
            Polyline(
              polylineId: PolylineId('routeToEnd'),
              points: listOflatLng,
              endCap: Cap.roundCap,
              startCap: Cap.roundCap,
            )
          },
          cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            northeast: LatLng(
                state.request.directions.routes.first.bounds.northeast.lat,
                state.request.directions.routes.first.bounds.northeast.lng),
            southwest: LatLng(
                state.request.directions.routes.first.bounds.southwest.lat,
                state.request.directions.routes.first.bounds.southwest.lng),
          )),
          initialCameraPosition: CameraPosition(
            target: LatLng(state.request.position.latitude,
                state.request.position.longitude),
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
                        Text('Estimated order arrival time'),
                        Text(
                          '$optimistic - $pessmistic',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Divider(),
                        Text(
                          'In Transit',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                            'Your driver is arriving at your location to delivery your food!'),
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
                                    state.request.driverName ??
                                        'No Driver Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(children: [
                                    Text(state.request.vehicleData.brand + ' '),
                                    Text(state.request.vehicleData.model + ' '),
                                    Text(state.request.vehicleData.color + ' '),
                                    Text(' - '),
                                    Text(state.request.vehicleData.plate)
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
                                launch('tel:${state.request.driverNumber}'),
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
                          '${state.request.pickup.name}',
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
                              'PHP ${(state.request.subtotal + state.request.fee).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(),
                        ListTile(
                          leading:
                              Text('${state.request.items.first.quantity}x'),
                          title: Text(
                              'You ordered ${state.request.items.first.itemName}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: (state.request.items.length > 1)
                              ? Text('+ ${state.request.items.length - 1} more')
                              : Container(),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(),
                        FlatButton.icon(
                          icon: Icon(Icons.chevron_right),
                          onPressed: () => pushNewScreen(context,
                              screen: SeeMoreDetailsPage()),
                          textColor: Theme.of(context).primaryColor,
                          label: Text(
                            'See More Details',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
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
                              child: Text('${state.request.pickup.address}')),
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
                              child:
                                  Text('${state.request.destination.address}')),
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
