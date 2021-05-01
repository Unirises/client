import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  (state.pickup == null || state.pickup.id == null)
                      ? Text(
                          'Start booking a parcel delivery by adding your pickup location.',
                          style: TextStyle(fontSize: 24),
                        )
                      : Container(),
                  (state.pickup?.id != null)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Location',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.pin_drop_sharp,
                                color: Color(0xff424242),
                              ),
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
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    color: Colors.blue,
                                    onPressed: () async {
                                      LocationResult result =
                                          await showLocationPicker(
                                        context,
                                        'AIzaSyAt9lUp_riyazE0ZgeSPya-HPtiWBxkMiU',
                                        initialCenter: LatLng(
                                            state.pickup.location.lat,
                                            state.pickup.location.lng),
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
                                                  floor:
                                                      state.pickup.houseDetails,
                                                  name: state.pickup.name,
                                                  phone: state.pickup.phone,
                                                  weight: state.pickup.weight,
                                                  id: state.pickup.id,
                                                  typeOfParcel:
                                                      state.pickup.type,
                                                  location: result,
                                                  isPickup: true,
                                                  onSubmitFinished: (data) {
                                                    Navigator.pop(context);
                                                    context
                                                        .read<ParcelBloc>()
                                                        .add(ParcelUpdated(
                                                          data,
                                                          true,
                                                        ));
                                                  },
                                                  onCancelled: () {
                                                    Navigator.pop(context);
                                                    return Flushbar(
                                                      title: 'Event cancelled',
                                                      message:
                                                          'You cancelled adding a stop in your parcel data.',
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
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      context.read<ParcelBloc>().add(
                                          ParcelDeleted(state.pickup, true));
                                    },
                                    icon: Icon(Icons.delete_forever),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  (state.points != null)
                      ? Text(
                          state.points.length > 1
                              ? 'Destinations'
                              : 'Destination',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 24),
                        )
                      : (state.pickup != null && state.pickup.id != null)
                          ? Text(
                              'Add your destinations to your parcel delivery.',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24),
                            )
                          : Container(),
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(
                            Icons.circle,
                            color: Theme.of(context).primaryColor,
                          ),
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
                                'Phone: ' + state.points[index].phone,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                state.points[index].houseDetails +
                                    ' ' +
                                    state.points[index].address,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                state.points[index].type +
                                    ' - ${state.points[index].weight.toStringAsFixed(2)} kg',
                                style: TextStyle(color: Colors.grey),
                              ),
                              (state.points[index].distance != null)
                                  ? Text(
                                      (state.points[index].distance / 1000)
                                              .toStringAsFixed(2) +
                                          ' km | ${state.points[index].duration.text}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16))
                                  : Container(),
                              state.points[index].price != null
                                  ? Text(
                                      'Price: PHP ${state.points[index].price.toStringAsFixed(2)}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.5),
                                    )
                                  : Container(),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                color: Colors.blue,
                                onPressed: () async {
                                  LocationResult result =
                                      await showLocationPicker(
                                    context,
                                    'AIzaSyAt9lUp_riyazE0ZgeSPya-HPtiWBxkMiU',
                                    initialCenter: LatLng(
                                        state.points[index].location.lat,
                                        state.points[index].location.lng),
                                    countries: ['PH'],
                                    desiredAccuracy: LocationAccuracy.best,
                                  );
                                  if (result == null || result.address == null)
                                    return;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddStopDetailsPage(
                                              floor: state
                                                  .points[index].houseDetails,
                                              name: state.points[index].name,
                                              phone: state.points[index].phone,
                                              weight:
                                                  state.points[index].weight,
                                              id: state.points[index].id,
                                              typeOfParcel:
                                                  state.points[index].type,
                                              location: result,
                                              isPickup:
                                                  state.pickup?.id == null,
                                              onSubmitFinished: (data) {
                                                Navigator.pop(context);
                                                context
                                                    .read<ParcelBloc>()
                                                    .add(ParcelUpdated(
                                                      data,
                                                      state.pickup?.id == null,
                                                    ));
                                              },
                                              onCancelled: () {
                                                Navigator.pop(context);
                                                return Flushbar(
                                                  title: 'Event cancelled',
                                                  message:
                                                      'You cancelled adding a stop in your parcel data.',
                                                  duration:
                                                      Duration(seconds: 5),
                                                  isDismissible: false,
                                                  showProgressIndicator: true,
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
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                color: Colors.red,
                                onPressed: () {
                                  context.read<ParcelBloc>().add(ParcelDeleted(
                                      state.points[index], false));
                                },
                                icon: Icon(Icons.delete_forever),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount:
                          (state.points != null) ? state.points?.length : 0,
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
                            child: ElevatedButton.icon(
                                onPressed: ((state.points != null)
                                        ? state.points.length < 22
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
                                                          .read<ParcelBloc>()
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
                                    'Add ${state.pickup?.id == null ? 'Starting Point' : 'Destination'}'))),
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
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: state.type != null
                                          ? null
                                          : Theme.of(context).primaryColor),
                                  onPressed: () {
                                    context
                                        .read<ParcelBloc>()
                                        .add(ComputeFare());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SelectVehiclePage(
                                          onSelected: (selected) {
                                            Navigator.pop(context);
                                            context
                                                .read<ParcelBloc>()
                                                .add(TypeUpdated(selected));
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                      '${state.type != null ? 'Change Vehicle' : 'Select Vehicle'}',
                                      style: TextStyle(
                                        color: state.type != null
                                            ? null
                                            : Colors.white,
                                      )),
                                ),
                              ),
                            )
                          : Container(),
                      ((state?.subtotal ?? 0) > 0 &&
                              state.points.length != null &&
                              state.points.length > 0 &&
                              state.pickup != null &&
                              state.pickup.id != null)
                          ? Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<ParcelBloc>().add(
                                          RequestParcel(
                                              rideBloc: context
                                                  .read<ParcelRideBloc>(),
                                              name: (context
                                                          .read<
                                                              UserCollectionBloc>()
                                                          .state
                                                      as UserCollectionLoaded)
                                                  .userCollection
                                                  .name,
                                              number: (context
                                                          .read<
                                                              UserCollectionBloc>()
                                                          .state
                                                      as UserCollectionLoaded)
                                                  .userCollection
                                                  .phone),
                                        );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                  ),
                                  child: Text(
                                    'Request Parcel Delivery - PHP ${state.subtotal.toStringAsFixed(2)} | ${(state.data['distance'] / 1000).toStringAsFixed(2)} km',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
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
}
