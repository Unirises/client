import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/client_bloc/client_bloc.dart';
import '../../../core/models/Request.dart';
import '../../pabili/pages/orders_view.dart';

class MapBottomSheet extends StatelessWidget {
  const MapBottomSheet({
    Key key,
    @required this.headerText,
    @required this.subtitleWidget,
    @required this.request,
    @required this.ride_id,
    @required this.leadingTitle,
    @required this.leadingAction,
  }) : super(key: key);

  final String headerText;
  final Widget subtitleWidget;
  final Request request;
  final String ride_id;
  final String leadingTitle;
  final String leadingAction; // arrived, transit

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15.0,
            spreadRadius: 0.5,
            offset: Offset(
              0.7,
              0.7,
            ),
          )
        ],
      ),
      height: 195,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
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
                    headerText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 22.0),
                  ),
                  // Text(request.vehicle_data),
                  Text(
                      '${request.driverName} - ${request.vehicle_data['brand']} ${request.vehicle_data['model']} ${request.vehicle_data['color']} - ${request.vehicle_data['plate']}'),
                  subtitleWidget,
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await launch('tel:${request.driverNumber}');
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 1.0, color: Colors.grey),
                          ),
                          child: Icon(
                            Icons.call,
                            size: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Call ${request.driverName}',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                (request.isFoodDelivery)
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            pushNewScreen(
                              context,
                              screen: OrdersView(request),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      width: 1.0, color: Colors.grey),
                                ),
                                child: Icon(
                                  Icons.shopping_bag,
                                  size: 25,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                child: Text(
                                  'Order Details',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context
                          .bloc<ClientBloc>()
                          .add(ClientCancelRide(request.id));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 1.0, color: Colors.grey),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 25,
                            color: Theme.of(context).primaryColor,
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
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).primaryColor,
                    backgroundImage: NetworkImage(request.driverPhoto != null
                        ? request.driverPhoto
                        : 'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.driverName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(request.driverNumber),
                    ],
                  )
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  Expanded(
                      child: Text(request.pickup.address,
                          textAlign: TextAlign.center)),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.forward),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(request.destination.address,
                        textAlign: TextAlign.center),
                  ),
                ]),
                SizedBox(
                  height: 12,
                ),
                Row(children: [
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.moneyBill,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Cash')
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Row(
                    children: [
                      Text('PHP ${request.price}'),
                    ],
                  ),
                ]),
                Row(children: [
                  Text(
                      'Travel Time: ${(request.duration / 60).round()} minutes (${((request.duration - DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(request.timestamp)).inSeconds) / 60).round()} min remaining)'),
                  Expanded(
                    child: Container(),
                  ),
                  Row(
                    children: [
                      Text(
                          '${request.distance > 1000 ? (request.distance / 1000).round().toString() + ' km' : request.distance.toString() + ' miles'}'),
                    ],
                  ),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
