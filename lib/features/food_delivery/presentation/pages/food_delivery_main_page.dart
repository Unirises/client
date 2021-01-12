import 'dart:developer';

import 'package:client/core/client_bloc/client_bloc.dart';
import 'package:client/features/food_delivery/bloc/checkout_bloc.dart';
import 'package:client/features/food_delivery/bloc/merchant_bloc.dart';
import 'package:client/features/food_delivery/presentation/pages/food_delivery_requesting_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'food_idle_page.dart';

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
                  log(clientState.client.delivery_status);
                  if (clientState.client.delivery_status == 'idle') {
                    return FoodIdlePage();
                  } else if (clientState.client.delivery_status ==
                      'requesting') {
                    return FoodDeliveryRequestingPage();
                  } else if (clientState.client.delivery_status == 'transit') {
                  } else if (clientState.client.delivery_status == 'arrived') {
                  } else if (clientState.client.delivery_status == 'arriving') {
                  } else if (clientState.client.delivery_status ==
                          'cancelled' ||
                      clientState.client.delivery_status == 'completed') {}
                  return Text(clientState.client.delivery_status.toString());
                }
              });
            }
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
