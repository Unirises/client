import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../bloc/checkout_bloc.dart';
import '../../bloc/merchant_bloc.dart';
import '../../models/Merchant.dart';
import '../pages/food_delivery_listing_page.dart';
import '../widgets/time_location_widget.dart';

class FoodIdlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MerchantBloc, MerchantState>(
      builder: (context, state) {
        if (state is MerchantInitial) {
          context.read<MerchantBloc>().add(FetchMerchants());
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
                        checkoutState.items!.length > 0
                    ? FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          context.read<CheckoutBloc>().add(CheckoutStoreUpdated(
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
                          'Browse now to shop, and to satisfy your needs!',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      (state.merchants.isEmpty)
                          ? Center(
                              child: Text(
                                'No restaurants available.',
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: (!state.merchants[index].isOpen!)
                                          ? null
                                          : () {
                                              if (checkoutState.merchant ==
                                                  null) {
                                                if (checkoutState.merchant
                                                        ?.companyName ==
                                                    null) {
                                                  context
                                                      .read<CheckoutBloc>()
                                                      .add(CheckoutStoreUpdated(
                                                          state.merchants[
                                                              index]));
                                                  pushNewScreen(context,
                                                      screen:
                                                          FoodDeliveryListingPage(
                                                        merchant: state
                                                            .merchants[index],
                                                      ));
                                                }
                                              } else {
                                                if (state.merchants[index]
                                                        .companyName ==
                                                    checkoutState.merchant!
                                                        .companyName) {
                                                  context
                                                      .read<CheckoutBloc>()
                                                      .add(CheckoutStoreUpdated(
                                                          state.merchants[
                                                              index]));
                                                  pushNewScreen(context,
                                                      screen:
                                                          FoodDeliveryListingPage(
                                                        merchant: state
                                                            .merchants[index],
                                                      ));
                                                } else {
                                                  if (checkoutState.items ==
                                                          null ||
                                                      checkoutState
                                                              .items!.length <
                                                          1) {
                                                    context
                                                        .read<CheckoutBloc>()
                                                        .add(
                                                            CheckoutStoreUpdated(
                                                                state.merchants[
                                                                    index]));
                                                    pushNewScreen(context,
                                                        screen:
                                                            FoodDeliveryListingPage(
                                                          merchant: state
                                                              .merchants[index],
                                                        ));
                                                  } else {
                                                    Flushbar(
                                                      title:
                                                          'Restaurant Selection Failed',
                                                      message:
                                                          'Sorry but you still have items from other restaurants.',
                                                      progressIndicatorBackgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      flushbarPosition:
                                                          FlushbarPosition.TOP,
                                                    )..show(context);
                                                    return null;
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
                                                          image: (state.merchants[index].hero !=
                                                                  null
                                                              ? NetworkImage(state
                                                                      .merchants[
                                                                          index]
                                                                      .hero ??
                                                                  'https://live.staticflickr.com/3780/9134266649_3d2f1af95b_z.jpg')
                                                              : AssetImage(
                                                                  'assets/default-hero.jpg')) as ImageProvider<
                                                              Object>,
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 10,
                                                child: Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          state.merchants[index]
                                                              .companyName!,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 24,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: state
                                                                  .merchants[
                                                                      index]
                                                                  .isOpen!
                                                              ? TimeLocationWidget(
                                                                  merchant: state
                                                                          .merchants[
                                                                      index],
                                                                )
                                                              : Text(
                                                                  'Store unavailable, opens at: ${state.merchants[index].startTime}'),
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
            return Container();
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
