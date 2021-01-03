import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../cubit/book_cubit.dart';

class MapSelectionButton extends StatelessWidget {
  const MapSelectionButton({
    Key key,
    this.cubit,
    this.isPickup,
  }) : super(key: key);

  final BookCubit cubit;
  final bool isPickup;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showLocationPicker(
          context,
          'AIzaSyBWlDJm4CJ_PAhhrC0F3powcfmy_NJEn2E',
          initialCenter: LatLng(14.6091, 121.0223),
          automaticallyAnimateToCurrentLocation: true,
          myLocationButtonEnabled: true,
          requiredGPS: true,
          countries: ['PH'],
          desiredAccuracy: LocationAccuracy.best,
        ).then((LocationResult value) {
          var data = {
            'address': value.address,
            'coordinates': {
              'lat': value.latLng.latitude,
              'lng': value.latLng.longitude,
            },
          };
          isPickup
              ? cubit.pickupPointChanged(data)
              : cubit.dropoffPointChanged(data);
        });
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: buildText(),
        ),
      ),
    );
  }

  Widget buildText() {
    if (isPickup) {
      return Text(
        cubit.state.pickupPoint.value.isEmpty
            ? 'Select pick-up location'
            : cubit.state.pickupPoint.value['address'].toString(),
        textAlign: TextAlign.center,
      );
    }
    return Text(
      cubit.state.dropoffPoint.value.isEmpty
          ? 'Select drop-off location'
          : cubit.state.dropoffPoint.value['address'].toString(),
      textAlign: TextAlign.center,
    );
  }
}
