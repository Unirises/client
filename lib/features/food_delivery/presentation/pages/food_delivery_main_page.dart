import 'package:client/features/food_delivery/presentation/pages/food_delivery_listing_page.dart';
import 'package:client/features/food_delivery/presentation/widgets/time_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../bloc/merchant_bloc.dart';

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
          return SafeArea(
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
                            pushNewScreen(context,
                                screen: FoodDeliveryListingPage(
                                  merchant: state.merchants[index],
                                ));
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
                                              image: state.merchants[index]
                                                          .hero !=
                                                      null
                                                  ? NetworkImage(state
                                                          .merchants[index]
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
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              state
                                                  .merchants[index].companyName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                              ),
                                            ),
                                            Expanded(
                                              child: TimeLocationWidget(
                                                merchant:
                                                    state.merchants[index],
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
          );
        } else if (state is MerchantLoadFailure) {
          return Center(
              child: Text('There was a problem accessing merchants data.'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
