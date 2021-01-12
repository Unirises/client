import 'dart:developer';

import 'package:client/core/client_bloc/client_bloc.dart';
import 'package:client/features/food_delivery/bloc/checkout_bloc.dart';
import 'package:client/features/food_delivery/bloc/merchant_bloc.dart';
import 'package:client/features/food_delivery/models/Merchant.dart';
import 'package:client/features/food_delivery/presentation/widgets/time_location_widget.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'food_delivery_listing_page.dart';

class FoodIdlePage extends StatelessWidget {
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
              return Scaffold(
                floatingActionButton: checkoutState.items != null &&
                        checkoutState.items.length > 0
                    ? FloatingActionButton(
                        onPressed: () {
                          context.bloc<CheckoutBloc>().add(CheckoutStoreUpdated(
                              Merchant(companyName: null, id: 'dasdas')));
                        },
                        child: Text('Clear'),
                      )
                    : Container(),
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Browse now to shop, and to satisfy your cravings!',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (checkoutState.merchant == null) {
                                    log((checkoutState.merchant?.companyName ==
                                            null)
                                        .toString());
                                    if (checkoutState.merchant?.companyName ==
                                        null) {
                                      context.bloc<CheckoutBloc>().add(
                                          CheckoutStoreUpdated(
                                              state.merchants[index]));
                                      pushNewScreen(context,
                                          screen: FoodDeliveryListingPage(
                                            merchant: state.merchants[index],
                                          ));
                                    }
                                  } else {
                                    if (state.merchants[index].companyName ==
                                        checkoutState.merchant.companyName) {
                                      context.bloc<CheckoutBloc>().add(
                                          CheckoutStoreUpdated(
                                              state.merchants[index]));
                                      pushNewScreen(context,
                                          screen: FoodDeliveryListingPage(
                                            merchant: state.merchants[index],
                                          ));
                                    } else {
                                      if (checkoutState.items == null ||
                                          checkoutState.items.length < 1) {
                                        context.bloc<CheckoutBloc>().add(
                                            CheckoutStoreUpdated(
                                                state.merchants[index]));
                                        pushNewScreen(context,
                                            screen: FoodDeliveryListingPage(
                                              merchant: state.merchants[index],
                                            ));
                                      } else {
                                        return Flushbar(
                                          title: 'Restaurant Selection Failed',
                                          message:
                                              'Sorry but you still have items from other restaurants.',
                                          progressIndicatorBackgroundColor:
                                              Theme.of(context).primaryColor,
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                        )..show(context);
                                      }
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      height: 120,
                                      padding: const EdgeInsets.all(0),
                                      child: Row(children: [
                                        Expanded(
                                          flex: 6,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: state
                                                                .merchants[
                                                                    index]
                                                                .hero !=
                                                            null
                                                        ? NetworkImage(state
                                                                .merchants[
                                                                    index]
                                                                .hero ??
                                                            'https://live.staticflickr.com/3780/9134266649_3d2f1af95b_z.jpg')
                                                        : AssetImage(
                                                            'assets/default-hero.jpg'),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    state.merchants[index]
                                                        .companyName,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: TimeLocationWidget(
                                                      merchant: state
                                                          .merchants[index],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: state.merchants.length),
                      ),
                    ],
                  ),
                ),
              );
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
