import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/Merchant.dart';

class TimeLocationWidget extends StatelessWidget {
  final Merchant? merchant;

  const TimeLocationWidget({Key? key, this.merchant}) : super(key: key);

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
              builder: (context, AsyncSnapshot<Position> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  Position data = snapshot.data!;
                  var distance = Geolocator.distanceBetween(
                    data.latitude,
                    data.longitude,
                    merchant!.place!.lat,
                    merchant!.place!.lng,
                  );
                  return Text(
                      '${merchant!.address != null ? merchant!.address! + ' | ' : ''}${(distance / 1000).round()} km away',
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
          Text('${merchant!.averageTimePreparation ?? 30} minutes')
        ]),
      ],
    );
  }
}
