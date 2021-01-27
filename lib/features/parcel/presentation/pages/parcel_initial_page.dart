import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/user_collection_bloc/user_collection_bloc.dart';
import '../../bloc/parcel_bloc.dart';
import '../../bloc/parcel_ride_bloc.dart';
import 'add_stop_details_page.dart';
import 'select_vehicle_page.dart';

class ParcelInitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParcelBloc, ParcelState>(
      builder: (context, state) {
        if (state is ParcelLoadSuccess) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (state.pickup == null && state.points == null)
                      ? Text(
                          'Start booking a parcel delivery by adding your pickup location.')
                      : Container(),
                  (state.pickup?.id != null)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Location',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            ListTile(
                              title: Text(
                                state.pickup.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.pickup.houseDetails +
                                        ' ' +
                                        state.pickup.address,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    state.pickup.phone,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                color: Colors.red,
                                onPressed: () {
                                  context
                                      .bloc<ParcelBloc>()
                                      .add(ParcelDeleted(state.pickup, true));
                                },
                                icon: Icon(Icons.delete_forever),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.only(top: 56),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: buildLeadingIcons(
                                    context, state.points?.length),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  state.points[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.points[index].houseDetails +
                                          ' ' +
                                          state.points[index].address,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      state.points[index].phone,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      state.points[index].type +
                                          ' - ${state.points[index].weight.toStringAsFixed(2)} kg',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  color: Colors.red,
                                  onPressed: () {
                                    context.bloc<ParcelBloc>().add(
                                        ParcelDeleted(
                                            state.points[index], false));
                                  },
                                  icon: Icon(Icons.delete_forever),
                                ),
                              );
                            },
                            itemCount: (state.points != null)
                                ? state.points?.length
                                : 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: RaisedButton.icon(
                                onPressed: ((state.points != null)
                                        ? state.points?.length < 22
                                        : true)
                                    ? () async {
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
                                          desiredAccuracy:
                                              LocationAccuracy.best,
                                        );
                                        if (result == null ||
                                            result.address == null) return;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddStopDetailsPage(
                                                    location: result,
                                                    isPickup:
                                                        state.pickup?.id ==
                                                            null,
                                                    onSubmitFinished: (data) {
                                                      Navigator.pop(context);
                                                      context
                                                          .bloc<ParcelBloc>()
                                                          .add(ParcelAdded(
                                                            data,
                                                            state.pickup?.id ==
                                                                null,
                                                          ));
                                                    },
                                                    onCancelled: () {
                                                      Navigator.pop(context);
                                                      return Flushbar(
                                                        title:
                                                            'Event cancelled',
                                                        message:
                                                            'You cancelled adding a stop in your parcel data.',
                                                        duration: Duration(
                                                            seconds: 5),
                                                        isDismissible: false,
                                                        showProgressIndicator:
                                                            true,
                                                        progressIndicatorBackgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        flushbarPosition:
                                                            FlushbarPosition
                                                                .TOP,
                                                      )..show(context);
                                                    },
                                                  )),
                                        );
                                      }
                                    : null,
                                icon: Icon(Icons.add),
                                label: Text(
                                    'Add ${state.pickup?.id == null ? 'Starting Point' : 'Stop'}'))),
                      ),
                      (state.points != null &&
                              state.points.length >= 1 &&
                              state.pickup.id != null)
                          ? Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: RaisedButton(
                                  onPressed: () {
                                    context
                                        .bloc<ParcelBloc>()
                                        .add(ComputeFare());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SelectVehiclePage(
                                          onSelected: (selected) {
                                            Navigator.pop(context);
                                            context
                                                .bloc<ParcelBloc>()
                                                .add(TypeUpdated(selected));
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  color: state.type != null
                                      ? null
                                      : Theme.of(context).primaryColor,
                                  textColor:
                                      state.type != null ? null : Colors.white,
                                  child: Text(
                                      '${state.type != null ? 'Change Vehicle' : 'Select Vehicle'}'),
                                ),
                              ),
                            )
                          : Container(),
                      ((state?.subtotal ?? 0) > 0)
                          ? Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: RaisedButton(
                                  onPressed: () {
                                    context
                                        .bloc<ParcelBloc>()
                                        .add(ComputeFare());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SelectVehiclePage(
                                          onSelected: (selected) {
                                            Navigator.pop(context);
                                            context.bloc<ParcelBloc>().add(
                                                  RequestParcel(
                                                      rideBloc: context.bloc<
                                                          ParcelRideBloc>(),
                                                      name: (context
                                                                  .bloc<
                                                                      UserCollectionBloc>()
                                                                  .state
                                                              as UserCollectionLoaded)
                                                          .userCollection
                                                          .name,
                                                      number: (context
                                                                  .bloc<
                                                                      UserCollectionBloc>()
                                                                  .state
                                                              as UserCollectionLoaded)
                                                          .userCollection
                                                          .phone),
                                                );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  child: Text('Book Request'),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  List<Widget> buildLeadingIcons(BuildContext context, int length) {
    if (length == null) length = 0;
    if (length < 1) return [Container()];
    if (length < 2)
      return [
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Icon(
            Icons.location_on,
            color: Theme.of(context).primaryColor,
          ),
        )
      ];

    List<Widget> widgets = [
      Icon(
        Icons.location_on,
        color: Theme.of(context).primaryColor,
      )
    ];

    for (int i = 0; i < length - 1; i++) {
      if (widgets.length < 9)
        widgets.insertAll(0, [
          const Icon(
            Icons.radio_button_checked,
            color: Colors.black,
          ),
          Dash(
              direction: Axis.vertical,
              length: 110,
              dashLength: 5,
              dashThickness: 3.0,
              dashColor: Colors.grey[400]),
        ]);
    }
    print(widgets.length);
    return widgets;
  }
}
