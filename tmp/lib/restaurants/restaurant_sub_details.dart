import 'package:flutter/material.dart';
import 'package:jg_express_client/models/Merchant.dart';

class RestaurantSubDetailWidget extends StatelessWidget {
  const RestaurantSubDetailWidget({Key key, this.restaurant}) : super(key: key);
  final Merchant restaurant;
  @override
  Widget build(BuildContext context) {
    TextStyle textTheme = TextStyle(fontSize: 12);
    double iconSize = 16;
    double subSpacing = 4;

    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: iconSize,
              ),
              SizedBox(
                width: subSpacing,
              ),
              Text(
                (restaurant.stars).toString(),
                style: textTheme,
              ),
              SizedBox(
                width: subSpacing,
              ),
              Icon(
                Icons.timer,
                size: iconSize,
              ),
              SizedBox(
                width: subSpacing,
              ),
              Text(
                restaurant.averageTimePreparation.toString() + ' min',
                style: textTheme,
              ),
              SizedBox(
                width: subSpacing,
              ),
              const Text('•'),
              SizedBox(
                width: subSpacing,
              ),
              Text(
                '${double.parse((restaurant.distance / 1000).toStringAsFixed(2))} km',
                style: textTheme,
              )
            ],
          ),
        ),
      ],
    );
  }
}
