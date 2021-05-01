import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/Merchant.dart';
import '../widgets/time_location_widget.dart';

class CompanyInfoDataPage extends StatelessWidget {
  final Merchant? merchant;

  const CompanyInfoDataPage({Key? key, this.merchant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: GoogleMap(
              liteModeEnabled: true,
              markers: {
                Marker(
                    markerId: MarkerId('yes'),
                    position: LatLng(merchant!.place!.lat!, merchant!.place!.lng!),
                    infoWindow: InfoWindow(title: merchant!.companyName))
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(merchant!.place!.lat!, merchant!.place!.lng!),
                zoom: 20,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    merchant!.companyName!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  TimeLocationWidget(
                    merchant: merchant,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Prices are all VAT inclusive. Prices may also vary or be subject to change by the merchant.',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Text(
                          'Location',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          merchant!.address ?? '',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Text(
                          'Operating Hours',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${merchant!.startTime ?? ''} - ${merchant!.endTime ?? ''}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
