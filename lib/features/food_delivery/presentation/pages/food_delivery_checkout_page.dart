import 'package:client/features/food_delivery/bloc/checkout_bloc.dart';
import 'package:client/features/parcel/presentation/pages/add_stop_details_page.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FoodDeliveryCheckoutPage extends StatelessWidget {
  final Function onBooked;

  const FoodDeliveryCheckoutPage({Key key, this.onBooked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
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
        return Scaffold(
            appBar: AppBar(
                title: Column(
                  children: [
                    Text(state.merchant.companyName),
                    (state.destination != null &&
                            state.destination.duration != null)
                        ? Row(children: [
                            Text(
                                'Distance from you: ${(state.destination.distance / 1000).toStringAsFixed(2)} km'),
                            Text(state.destination.duration.text),
                          ])
                        : Container(),
                  ],
                ),
                centerTitle: true),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  RaisedButton(
                    child: Text('Select Location'),
                    onPressed: () async {
                      LocationResult result = await showLocationPicker(
                        context,
                        'AIzaSyAt9lUp_riyazE0ZgeSPya-HPtiWBxkMiU',
                        initialCenter: LatLng(14.6091, 121.0223),
                        automaticallyAnimateToCurrentLocation: true,
                        myLocationButtonEnabled: true,
                        requiredGPS: true,
                        countries: ['PH'],
                        desiredAccuracy: LocationAccuracy.best,
                      );
                      if (result == null || result.address == null) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddStopDetailsPage(
                                  location: result,
                                  isPickup: true,
                                  onSubmitFinished: (data) {
                                    Navigator.pop(context);
                                    context
                                        .bloc<CheckoutBloc>()
                                        .add(CheckoutDestinationUpdated(data));
                                  },
                                  onCancelled: () {
                                    Navigator.pop(context);
                                    return Flushbar(
                                      title: 'Event cancelled',
                                      message:
                                          'You cancelled adding a stop in your parcel data.',
                                      duration: Duration(seconds: 5),
                                      isDismissible: false,
                                      showProgressIndicator: true,
                                      progressIndicatorBackgroundColor:
                                          Theme.of(context).primaryColor,
                                      flushbarPosition: FlushbarPosition.TOP,
                                    )..show(context);
                                  },
                                )),
                      );
                    },
                  )
                ],
              ),
            ));
      }
    });
  }
}
