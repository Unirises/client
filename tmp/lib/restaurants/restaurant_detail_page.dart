import 'package:flutter/material.dart';
import 'package:jg_express_client/models/Merchant.dart';
import 'package:jg_express_client/restaurants/restaurant_classifications.dart';
import 'package:jg_express_client/restaurants/restaurant_company_page.dart';
import 'package:jg_express_client/restaurants/restaurant_sub_details.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class RestaurantDetail extends StatelessWidget {
  const RestaurantDetail({Key key, this.restaurant}) : super(key: key);

  final Merchant restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                stretch: true,
                pinned: true,
                floating: false,
                actions: [
                  const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.search),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                    stretchModes: [StretchMode.zoomBackground],
                    background: Hero(
                      tag: restaurant.id,
                      child: Image.network(
                        restaurant.hero,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.companyName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                          RestaurantClassificationsWidget(restaurant),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () {
                          pushNewScreen(
                            context,
                            screen: RestaurantCompanyPage(
                              restaurant: restaurant,
                            ),
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RestaurantSubDetailWidget(
                        restaurant: restaurant,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
