import 'package:client/features/food_delivery/models/Merchant.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TimeLocationWidget extends StatelessWidget {
  final Merchant merchant;

  const TimeLocationWidget({Key key, this.merchant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Icon(Icons.location_pin),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: FutureBuilder(
              future: Geolocator.getCurrentPosition(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Position data = snapshot.data;
                  var distance = Geolocator.distanceBetween(
                    data.latitude,
                    data.longitude,
                    merchant.place.lat,
                    merchant.place.lng,
                  );
                  return Text(
                      '${merchant.address != null ? merchant.address + ' | ' : ''}${(distance / 1000).round()} km away',
                      overflow: TextOverflow.clip);
                }
                return Text('...');
              },
            ),
          ),
        ]),
        Row(children: [
          Icon(Icons.alarm),
          SizedBox(
            width: 4,
          ),
          Text('${merchant.averageTimePreparation ?? 30} minutes')
        ]),
      ],
    );
  }
}
