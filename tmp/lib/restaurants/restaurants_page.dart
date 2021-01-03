import 'package:flutter/material.dart';
import 'package:jg_express_client/models/Merchant.dart';
import 'package:jg_express_client/restaurants/restaurant_classifications.dart';
import 'package:jg_express_client/restaurants/restaurant_sub_details.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'bloc/restaurants_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'restaurant_detail_page.dart';

class RestaurantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<RestaurantsBloc>().add(FetchRestaurants());

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              'Restaurants Near Your Area',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          BlocBuilder<RestaurantsBloc, RestaurantsState>(
            builder: (context, state) {
              if (state is RestaurantsLoaded) {
                return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            pushNewScreen(
                              context,
                              screen: RestaurantDetail(
                                restaurant: state.restaurants[index],
                              ),
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade,
                            );
                          },
                          child: RestaurantListingItem(
                            restaurant: state.restaurants[index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        );
                      },
                      itemCount: state.restaurants.length),
                );
              }
              return const CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}

class RestaurantListingItem extends StatelessWidget {
  const RestaurantListingItem({Key key, this.restaurant}) : super(key: key);
  final Merchant restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Hero(
                tag: restaurant.id,
                child: Image.network(
                  restaurant.hero,
                  fit: BoxFit.cover,
                  height: 100.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    restaurant.companyName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  RestaurantClassificationsWidget(restaurant),
                  const SizedBox(
                    height: 8,
                  ),
                  RestaurantSubDetailWidget(
                    restaurant: restaurant,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
