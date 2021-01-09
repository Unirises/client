import 'package:client/features/food_delivery/bloc/checkout_bloc.dart';
import 'package:client/features/food_delivery/bloc/item_bloc.dart';
import 'package:client/features/food_delivery/models/Merchant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

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
            appBar: AppBar(
              centerTitle: true,
              title: Text(widget.merchant.companyName),
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: widget.merchant.listing.listing
                    .map((e) => Tab(
                          text: e.classificationName,
                        ))
                    .toList(),
              ),
            ),
            body: Column(
              children: [
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
                                        listing
                                            .classificationListing[itemIndex]));
                                    pushNewScreen(context,
                                        screen: ItemListingSelectionPage(
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
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
