import 'package:flutter/material.dart';
import 'package:jg_express_client/models/Merchant.dart';

class RestaurantClassificationsWidget extends StatelessWidget {
  RestaurantClassificationsWidget(this.restaurant);
  final Merchant restaurant;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Filipino Food, Burger, Chicken, Fast Food, American',
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );
  }
}
