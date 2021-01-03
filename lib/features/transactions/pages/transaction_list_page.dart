import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../core/client_bloc/client_bloc.dart';
import 'transaction_page.dart';

class TransactionListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientBloc, ClientState>(
      buildWhen: (prevState, newState) {
        if (prevState is ClientLoaded && newState is ClientLoaded) {
          return prevState.client.rides != newState.client.rides;
        }
        return true;
      },
      builder: (context, state) {
        if (state is ClientLoaded) {
          List<num> listOfEarnedMoney = [];
          var sumofListEarnedMoney;
          if (state.client.rides.length > 0) {
            state.client.rides.forEach((element) {
              if (element.status == 'completed') {
                return listOfEarnedMoney.add(element.price);
              }
            });
            if (listOfEarnedMoney.length > 0) {
              sumofListEarnedMoney =
                  listOfEarnedMoney.reduce((value, element) => value + element);
              state.client.rides
                  .sort((b, a) => a.timestamp.compareTo(b.timestamp));
            }
          }

          return Scaffold(
            appBar: AppBar(
              leading: BackButton(),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: (state.client.rides.length > 0)
                ? Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: Colors.black,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'PHP ${sumofListEarnedMoney != null ? sumofListEarnedMoney?.toStringAsFixed(2) : 0}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                              Text(
                                'Total Amount of Transactions',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var ride = state.client.rides[index];

                                return ListTile(
                                  onTap: () {
                                    pushNewScreen(
                                      context,
                                      screen: TransactionPage(
                                        request: ride,
                                      ),
                                      withNavBar: false,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  title: Text((ride.pickup.place ??
                                          ride.pickup.address) +
                                      ' - ' +
                                      ride.destination.address),
                                  trailing: Text((ride.isFoodDelivery ?? false)
                                      ? 'PHP ' +
                                          ride.data['fee'].toStringAsFixed(2)
                                      : 'PHP ' + ride.price.toStringAsFixed(2)),
                                  subtitle: Text(
                                    'Ride ${capitalize(ride.status)}',
                                    style: TextStyle(
                                        color: buildTileColor(ride.status)),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              itemCount: state.client.rides.length,
                            ),
                          )),
                    ],
                  )
                : Container(
                    child: Center(
                        child: Text("You haven't done any ride requests yet.")),
                  ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildRideTypeImage(String ride_type) {
    switch (ride_type) {
      case 'car2Seater':
        return Image.asset('assets/rideshare/car-2-seater.png');
        break;
      case 'car4Seater':
        return Image.asset('assets/rideshare/car-4-seater.png');
        break;
      case 'motorcycle':
        return Image.asset('assets/rideshare/motorcycle.png');
        break;
      case 'car7Seater':
        return Image.asset('assets/rideshare/van.png');
        break;
      default:
        return Image.asset('assets/rideshare/car-2-seater.png');
        break;
    }
  }

  Color buildTileColor(String status) {
    switch (status) {
      case 'cancelled':
        return Colors.red;
        break;
      case 'completed':
        return Colors.green;
        break;
      default:
        return Colors.white;
        break;
    }
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
