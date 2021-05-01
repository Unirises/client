import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/food_ride_bloc.dart';
import '../../models/classification_listing.dart';

class SeeMoreDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = (context.watch<FoodRideBloc>().state as FoodRideLoaded);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CloseButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var item = state.request!.items![index];
                return ListTile(
                    title: Text('${item.itemName}'),
                    leading: Text('${item.quantity}x'),
                    trailing: Text(
                        'PHP ${((item.additionalPrice != null ? item.additionalPrice! + item.itemPrice! : item.itemPrice)! * item.quantity!).toStringAsFixed(2)}'),
                    subtitle: builtItemAdditionals(item));
              },
              itemCount: state.request!.items!.length,
            )
          ],
        ),
      ),
    );
  }

  Widget builtItemAdditionals(ClassificationListing item) {
    List<Map<String, dynamic>> additionalsList = [];

    item.additionals!.forEach((classification) {
      classification.additionalListing!.forEach((additional) {
        if (additional.isSelected != null && additional.isSelected!) {
          additionalsList.add({
            'title': '${classification.additionalName} - ${additional.name}',
            'price': additional.additionalPrice,
          });
        }
      });
    });

    if (additionalsList.length < 1) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: additionalsList
          .map((e) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e['title']),
                  Text(e['price'].toStringAsFixed(2))
                ],
              ))
          .toList(),
    );
  }
}
