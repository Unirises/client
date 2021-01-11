import 'package:client/features/food_delivery/bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodDeliveryCheckoutPage extends StatelessWidget {
  final Function onBooked;

  const FoodDeliveryCheckoutPage({Key key, this.onBooked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
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
          appBar: AppBar(title: Text(state.merchant.companyName)),
          body: Container(),
        );
      }
    });
  }
}
