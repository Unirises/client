import 'dart:developer';

import 'package:client/core/widgets/profile_picture.dart';
import 'package:client/features/food_delivery/bloc/food_ride_bloc.dart';
import 'package:client/features/food_delivery/presentation/pages/see_more_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodDeliveryArrivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = (context.bloc<FoodRideBloc>().state as FoodRideLoaded);

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                child: state.request.status == 'arriving'
                    ? Image.asset('assets/onboarding/driver.png')
                    : Image.asset('assets/picking_up.png'),
              ),
            ),
            Container(
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
                    '${state.request.status == 'arriving' ? 'Preparing' : 'Waiting'}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                      '${state.request.status == 'arriving' ? 'Found you a driver! On the way to the restaurant' : 'The driver has arrived. Waiting for your order to finish.'}'),
                ],
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
                                state.request.driverName ?? 'No Driver Name',
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
                      icon: Icon(Icons.call),
                    )
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
                      leading: Text('${state.request.items.first.quantity}x'),
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
                      onPressed: () =>
                          pushNewScreen(context, screen: SeeMoreDetailsPage()),
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
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
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
                      Expanded(child: Text('${state.request.pickup.address}')),
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
                          child: Text('${state.request.destination.address}')),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
