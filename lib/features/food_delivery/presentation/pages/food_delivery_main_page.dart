import 'package:client/features/food_delivery/bloc/food_ride_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/client_bloc/client_bloc.dart';
import '../../bloc/checkout_bloc.dart';
import '../../bloc/merchant_bloc.dart';
import '../state_pages/food_delivery_arrive_page.dart';
import '../state_pages/food_delivery_in_transit_page.dart';
import '../state_pages/food_delivery_requesting_page.dart';
import '../state_pages/food_idle_page.dart';

class FoodDeliveryMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantBloc, MerchantState>(
      builder: (context, state) {
        if (state is MerchantInitial) {
          context.bloc<MerchantBloc>().add(FetchMerchants());
          return Center(child: CircularProgressIndicator());
        } else if (state is MerchantLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MerchantLoadSuccess) {
          return BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, checkoutState) {
            if (checkoutState is CheckoutLoadingInProgress) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (checkoutState is CheckoutLoadFailure) {
              return Center(
                child: Text(
                    'There has been a problem processing merchant and checkout data.'),
              );
            } else if (checkoutState is CheckoutLoadSuccess) {
              return BlocBuilder<ClientBloc, ClientState>(
                  builder: (context, clientState) {
                if (clientState is ClientInitial) {
                  return Scaffold(
                    body: Center(
                      child:
                          Text('There was a problem loading your user data.'),
                    ),
                  );
                } else if (clientState is ClientLoaded) {
                  if (clientState.client.delivery_status == 'idle') {
                    return FoodIdlePage();
                  } else {
                    return BlocBuilder<FoodRideBloc, FoodRideState>(
                      builder: (context, foodRideState) {
                        if (foodRideState is FoodRideInitial) {
                          Future.delayed(Duration(seconds: 5), () {
                            context.bloc<FoodRideBloc>().add(
                                StartListenOnFoodRide((context
                                        .bloc<ClientBloc>()
                                        .state as ClientLoaded)
                                    .client
                                    .delivery_id));
                          });
                          return Scaffold(
                            body: Center(
                              child: Text(
                                  "Please wait, making a fetch request to your current ride."),
                            ),
                          );
                        } else if (foodRideState is FoodRideLoading) {
                          return Scaffold(
                            body: Center(
                              child: Text(
                                  "Please wait, loading your current data."),
                            ),
                          );
                        } else if (foodRideState is FoodRideFailure) {
                          return Scaffold(
                            body: Center(
                              child: Text(
                                  "Sorry, there has been a problem loading your data. Please contact support."),
                            ),
                          );
                        } else if (foodRideState is FoodRideLoaded) {
                          if (clientState.client.delivery_status ==
                              'requesting') {
                            return FoodDeliveryRequestingPage();
                          } else if (clientState.client.delivery_status ==
                              'transit') {
                            return FoodDeliveryInTransitPage();
                          } else if (clientState.client.delivery_status ==
                              'arrived') {
                            return FoodDeliveryArrivePage();
                          } else if (clientState.client.delivery_status ==
                              'arriving') {
                            return FoodDeliveryArrivePage();
                          } else if (clientState.client.delivery_status ==
                                  'cancelled' ||
                              clientState.client.delivery_status ==
                                  'completed') {
                            return Scaffold(
                              body: Center(
                                child: Text(
                                    'Your ride is already completed. Please wait or refresh app.'),
                              ),
                            );
                          }
                        }
                        return Scaffold(
                          body: Center(
                            child: Text(
                                "Sorry, something wen't wrong processing your data. Please refresh app."),
                          ),
                        );
                      },
                    );
                  }
                }
                return Scaffold(
                  body: Center(
                    child: Text(
                        "Sorry, something wen't wrong loading your client data. Please refresh app."),
                  ),
                );
              });
            }
            return Scaffold(
              body: Center(
                child: Text(
                    "Sorry, something wen't wrong processing your checkout data. Please refresh app."),
              ),
            );
          });
        } else if (state is MerchantLoadFailure) {
          return Center(
              child: Text('There was a problem accessing merchants data.'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
