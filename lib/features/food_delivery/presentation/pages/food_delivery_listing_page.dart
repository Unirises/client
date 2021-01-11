import 'dart:developer';

import 'package:client/features/food_delivery/bloc/checkout_bloc.dart';
import 'package:client/features/food_delivery/bloc/item_bloc.dart';
import 'package:client/features/food_delivery/models/Merchant.dart';
import 'package:client/features/food_delivery/presentation/pages/company_info_data_page.dart';

import 'package:client/features/food_delivery/presentation/widgets/time_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'food_delivery_checkout_page.dart';
import 'item_listing_selection_page.dart';

class FoodDeliveryListingPage extends StatefulWidget {
  final Merchant merchant;

  const FoodDeliveryListingPage({Key key, this.merchant}) : super(key: key);

  @override
  _FoodDeliveryListingPageState createState() =>
      _FoodDeliveryListingPageState();
}

class _FoodDeliveryListingPageState extends State<FoodDeliveryListingPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        vsync: this, length: widget.merchant.listing.listing.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
        if (state is CheckoutLoadingInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CheckoutLoadFailure) {
          return Center(
            child: Text(
                'There has been a problem processing merchant and checkout data.'),
          );
        } else if (state is CheckoutLoadSuccess) {
          return Scaffold(
            floatingActionButton: (state.items != null &&
                    state.items.length > 0)
                ? FloatingActionButton(
                    child: Icon(Icons.shopping_basket),
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: (state.items != null && state.items.length > 0)
                        ? () {
                            pushNewScreen(context,
                                screen: FoodDeliveryCheckoutPage(
                              onBooked: () {
                                log('booked');
                              },
                            ));
                          }
                        : null,
                  )
                : null,
            body: NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, _) {
                return [
                  SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: false,
                    flexibleSpace: FlexibleSpaceBar(
                        stretchModes: [
                          StretchMode.zoomBackground,
                          StretchMode.blurBackground,
                        ],
                        background: widget.merchant.hero != null
                            ? Image.network(
                                widget.merchant.hero ??
                                    "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/default-hero.jpg',
                                fit: BoxFit.cover,
                              )),
                  ),
                ];
              },
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.merchant.companyName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.info_outline,
                              ),
                              onPressed: () {
                                pushNewScreen(context,
                                    screen: CompanyInfoDataPage(
                                      merchant: widget.merchant,
                                    ));
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TimeLocationWidget(
                          merchant: widget.merchant,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    child: TabBar(
                      labelColor: Colors.black,
                      controller: _tabController,
                      indicatorColor: Theme.of(context).primaryColor,
                      isScrollable: true,
                      tabs: widget.merchant.listing.listing
                          .map((e) => Tab(
                                text: e.classificationName,
                              ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        children: widget.merchant.listing.listing
                            .map(
                              (listing) => ListView.builder(
                                itemBuilder: (context, itemIndex) {
                                  return ListTile(
                                    onTap: () {
                                      context.bloc<ItemBloc>().add(ItemAdded(
                                          listing.classificationListing[
                                              itemIndex]));
                                      pushNewScreen(context,
                                          screen: ItemListingSelectionPage(
                                            itemIndex: itemIndex,
                                            classificationIndex:
                                                _tabController.index,
                                            onSuccess: (item) {
                                              context
                                                  .bloc<CheckoutBloc>()
                                                  .add(CheckoutItemAdded(item));
                                              Navigator.pop(context);
                                            },
                                          ));
                                    },
                                    title: Text(listing
                                        .classificationListing[itemIndex]
                                        .itemName),
                                    trailing: Text(
                                        'PHP ${listing.classificationListing[itemIndex].itemPrice}'),
                                  );
                                },
                                itemCount: listing.classificationListing.length,
                              ),
                            )
                            .toList()),
                  )
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
