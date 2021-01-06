import 'package:client/features/food_delivery/bloc/merchant_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    title: Text(state.merchants[index].companyName),
                  );
                },
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                itemCount: state.merchants.length),
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
