import 'package:client/features/pabili/blocs/cubit/checkout_cubit.dart'
    as CheckoutCubit;
import 'package:client/features/pabili/blocs/store/bloc/store_bloc.dart';
import 'package:client/features/pabili/models/Store.dart';
import 'package:client/features/pabili/pages/store_details_page.dart';
import 'package:client/features/pabili/widgets/store_listing_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class StoresListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit.CheckoutCubit,
        CheckoutCubit.CheckoutState>(
      builder: (context, checkoutState) {
        return BlocBuilder<StoreBloc, StoreState>(
          builder: (context, state) {
            if (state is StoresLoaded) {
              var stores = state.stores
                  .where((element) => element.categories.length > 0)
                  .toList();
              return Scaffold(
                body: FutureBuilder(
                  future: Geolocator.getCurrentPosition(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (!snapshot.hasError) {
                        stores.sort((a, b) {
                          var aRes = Geolocator.distanceBetween(
                            snapshot.data.latitude,
                            snapshot.data.longitude,
                            a.location.latitude,
                            a.location.longitude,
                          );
                          var bRes = Geolocator.distanceBetween(
                            snapshot.data.latitude,
                            snapshot.data.longitude,
                            b.location.latitude,
                            b.location.longitude,
                          );
                          return aRes.compareTo(bRes);
                        });

                        return SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Scaffold(
                              floatingActionButton: (checkoutState
                                          .items.length >
                                      0)
                                  ? FloatingActionButton(
                                      onPressed: () {
                                        context
                                            .bloc<CheckoutCubit.CheckoutCubit>()
                                            .resetStore();
                                      },
                                      child: Icon(Icons.clear),
                                    )
                                  : null,
                              body: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    child: Text(
                                      'Restaurants Near You',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              pushNewScreen(
                                                context,
                                                screen: StoreDetailsPage(
                                                  stores[index],
                                                ),
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .fade,
                                              );
                                            },
                                            child: buildList(
                                              stores: stores,
                                              index: index,
                                              snapshot: snapshot,
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return buildSeparator(
                                            index: index,
                                            stores: stores,
                                          );
                                        },
                                        itemCount: stores.length),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }
                    return Center(
                      child: Text('Getting current location details'),
                    );
                  },
                ),
              );
            } else {
              context.watch<StoreBloc>().add(FetchStore());
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }

  Widget buildList({List<Store> stores, int index, dynamic snapshot}) {
    return BlocBuilder<CheckoutCubit.CheckoutCubit,
        CheckoutCubit.CheckoutState>(builder: (context, state) {
      if (state.isInitial) {
        return StoreListingItem(
          store: stores[index],
          distance: Geolocator.distanceBetween(
            snapshot.data.latitude,
            snapshot.data.longitude,
            stores[index].location.latitude,
            stores[index].location.longitude,
          ),
        );
      } else {
        if (state.store == stores[index]) {
          return StoreListingItem(
            store: stores[index],
            distance: Geolocator.distanceBetween(
              snapshot.data.latitude,
              snapshot.data.longitude,
              stores[index].location.latitude,
              stores[index].location.longitude,
            ),
          );
        } else {
          return Container();
        }
      }
    });
  }

  Widget buildSeparator({List<Store> stores, int index}) {
    return BlocBuilder<CheckoutCubit.CheckoutCubit,
        CheckoutCubit.CheckoutState>(builder: (context, state) {
      if (state.isInitial) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(
            color: Colors.grey,
          ),
        );
      } else {
        if (state.store == stores[index]) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: Colors.grey,
            ),
          );
        } else {
          return Container();
        }
      }
    });
  }
}
