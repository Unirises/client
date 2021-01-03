import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jg_express_client/models/Merchant.dart';
import 'package:jg_express_client/restaurants/restaurant_classifications.dart';

import 'restaurant_sub_details.dart';

class RestaurantCompanyPage extends StatelessWidget {
  const RestaurantCompanyPage({Key key, @required this.restaurant})
      : assert(restaurant != null),
        super(key: key);

  final Merchant restaurant;

  @override
  Widget build(BuildContext context) {
    var pos = LatLng(
      cast<double>(restaurant.place['lat']),
      cast<double>(restaurant.place['lng']),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const CloseButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              liteModeEnabled: true,
              markers: {
                Marker(
                  markerId: MarkerId(restaurant.id),
                  position: pos,
                )
              },
              initialCameraPosition: CameraPosition(zoom: 19, target: pos),
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.companyName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    RestaurantClassificationsWidget(restaurant),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RestaurantSubDetailWidget(
                            restaurant: restaurant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Prices are all VAT inclusive. Prices may also vary or be subject to change by the merchant.',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            'Location',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            restaurant.address,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            'Operating Hours',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${restaurant.startTime} - ${restaurant.endTime}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text(
                            'Representative',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurant.representative['name'].toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                restaurant.representative['phone'].toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                restaurant.representative['email'].toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
