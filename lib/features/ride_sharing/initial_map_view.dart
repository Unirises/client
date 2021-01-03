import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../core/Flavor.dart';
import '../../core/authentication_bloc/authentication_bloc.dart';
import '../../core/client_bloc/client_bloc.dart';
import '../../core/initial_map_bloc/initial_map_bloc.dart';
import 'book_details_page.dart';

class InitialMapView extends StatefulWidget {
  @override
  _InitialMapViewState createState() => _InitialMapViewState();
}

class _InitialMapViewState extends State<InitialMapView> {
  Set<Marker> _markers = Set();

  @override
  Widget build(BuildContext context) {
    return (Provider.of<Flavor>(context) == Flavor.dev
            ? true
            : FirebaseAuth.instance.currentUser.emailVerified)
        ? BlocBuilder<ClientBloc, ClientState>(
            builder: (context, parentState) {
              if (parentState is ClientLoaded) {
                return BlocConsumer<InitialMapBloc, InitialMapState>(
                  listener: (context, state) {
                    if (state is NearbyDriversLoaded) {
                      state.drivers.forEach((element) {
                        if (element.position != null)
                          _markers.add(Marker(
                            markerId: MarkerId(element.id),
                            position: LatLng(element.position['latitude'],
                                element.position['longitude']),
                            // icon: snapshot.data[0],
                          ));
                      });
                      setState(() {});
                    }
                  },
                  builder: (context, state) {
                    if (state is InitialMapInitial) {
                      context.bloc<InitialMapBloc>().add(FetchNearbyDrivers());
                      return CircularProgressIndicator();
                    } else if (state is NearbyDriversLoaded) {
                      var listOfIcons = [
                        BitmapDescriptor.fromAssetImage(
                            ImageConfiguration(devicePixelRatio: 2.5),
                            'assets/rideshare-icons/car2Seater.png'),
                        BitmapDescriptor.fromAssetImage(
                            ImageConfiguration(devicePixelRatio: 2.5),
                            'assets/rideshare-icons/car4Seater.png'),
                        BitmapDescriptor.fromAssetImage(
                            ImageConfiguration(devicePixelRatio: 2.5),
                            'assets/rideshare-icons/motorcycle.png'),
                        BitmapDescriptor.fromAssetImage(
                            ImageConfiguration(devicePixelRatio: 2.5),
                            'assets/rideshare-icons/van.png'),
                      ];
                      return FutureBuilder(
                        future: Future.wait(listOfIcons),
                        builder:
                            (context, AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return Stack(
                              children: [
                                SafeArea(
                                  child: GoogleMap(
                                    myLocationEnabled: true,
                                    myLocationButtonEnabled: true,
                                    markers: state.drivers
                                        .where((element) {
                                          if (element.position != null) {
                                            if (element?.position[
                                                        'timestamp'] ==
                                                    null ||
                                                element?.position[
                                                        'timestamp'] ==
                                                    0) {
                                              return false;
                                            } else {
                                              return DateTime.now()
                                                      .difference(DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              element?.position[
                                                                  'timestamp']))
                                                      .inMinutes <
                                                  30;
                                            }
                                          }
                                          return false;
                                        })
                                        .map((element) => Marker(
                                            markerId: MarkerId(element.id),
                                            position: LatLng(
                                                element?.position['latitude'],
                                                element?.position['longitude']),
                                            rotation:
                                                element?.position['heading'],
                                            icon: snapshot.data[generateIcon(
                                                element?.ride_type)]
                                            // icon: snapshot.data[0],
                                            ))
                                        .toSet(),
                                    // markers: state.drivers
                                    initialCameraPosition: CameraPosition(
                                        target: LatLng(14.5995, 120.9842),
                                        zoom: 12),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18, horizontal: 14),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          // ignore: lines_longer_than_80_chars
                                          'Hello, ${context.bloc<AuthenticationBloc>().state.user.name}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.grey),
                                        ),
                                        const Text(
                                          'Where are you going?',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                        const SizedBox(height: 14),
                                        GestureDetector(
                                          onTap: () {
                                            pushNewScreen(
                                              context,
                                              screen: BookDetails(),
                                              withNavBar:
                                                  false, // OPTIONAL VALUE. True by default.
                                              pageTransitionAnimation:
                                                  PageTransitionAnimation
                                                      .cupertino,
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Icon(
                                                  Icons.circle,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 7,
                                                child: Container(
                                                  child: const Text(
                                                    'Set destination',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12,
                                                      vertical: 12),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    color: Colors.grey[100],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    }
                    return CircularProgressIndicator();
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        : Scaffold(
            body: Center(
              child: Text(
                'To use our ride sharing service,\nplease verify your email first.',
                textAlign: TextAlign.center,
              ),
            ),
          );
  }

  int generateIcon(String ride_type) {
    switch (ride_type) {
      case 'car2Seater':
        return 0;
        break;
      case 'car4Seater':
        return 1;
        break;
      case 'motorcycle':
        return 2;
        break;
      case 'car7Seater':
        return 3;
        break;
      default:
        return 0;
        break;
    }
  }
}
