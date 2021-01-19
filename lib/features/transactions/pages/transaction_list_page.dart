import 'package:client/features/parcel/built_models/built_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../core/client_bloc/client_bloc.dart';
import 'transaction_page.dart';
import 'package:timeago/timeago.dart' as timeago;

class TransactionListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<ClientBloc>().state as ClientLoaded;
    state.client.rides.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Transactions'),
      ),
      body: (state.client.rides != null && state.client.rides.length > 0)
          ? ListView.builder(
              itemBuilder: (context, index) {
                BuiltRequest item = state.client.rides[index];
                var date = DateTime.fromMillisecondsSinceEpoch(item.timestamp);
                return ListTile(
                  onTap: () => pushNewScreen(context,
                      screen: TransactionPage(ride: item)),
                  title:
                      Text(item.isParcel ? 'Parcel Delivery' : 'Food Delivery'),
                  subtitle: Text(timeago.format(date)),
                  leading: Text(
                      item.status == 'completed' ? 'Completed' : 'Cancelled'),
                  trailing: Text('PHP ' +
                      (item.isParcel
                          ? item.fee.toStringAsFixed(2)
                          : (item.fee + item.subtotal).toStringAsFixed(2))),
                );
              },
              itemCount: state.client.rides.length,
            )
          : Center(
              child: Text('You do not have any transactions yet.'),
            ),
    );
  }
}
