import 'package:client/features/transactions/bloc/transactions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/client_bloc/client_bloc.dart';
import '../../parcel/built_models/built_request.dart';
import 'transaction_page.dart';

class TransactionListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionsBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Transactions'),
        ),
        body: BlocBuilder<TransactionsBloc, TransactionsState>(
          builder: (context, state) {
            if (state is TransactionsInitial) {
              context.read<TransactionsBloc>().add(FetchTransactions());
              return Center(
                child: Text('Loading your latest transactions.'),
              );
            } else if (state is TransactionsLoading) {
              return Center(
                child: Text('Loading your latest transactions.'),
              );
            } else if (state is TransactionsFailure) {
              return Center(
                child: Text('There was a problem fetching your transactions.'),
              );
            } else if (state is TransactionsLoaded) {
              if (state.requests.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    BuiltRequest item = state.requests[index];
                    var date = DateTime.fromMillisecondsSinceEpoch(
                        item.timestamp as int);
                    return ListTile(
                      onTap: () => pushNewScreen(context,
                          screen: TransactionPage(ride: item)),
                      title: Text(
                          item.isParcel! ? 'Parcel Delivery' : 'Merchants'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(timeago.format(date)),
                          Text(
                              '${state.requests[index].rating.toStringAsFixed(0)} star rating')
                        ],
                      ),
                      leading: Text(item.status == 'completed'
                          ? 'Completed'
                          : 'Cancelled'),
                      trailing: Text('PHP ' +
                          (item.isParcel!
                              ? item.fee!.toStringAsFixed(2)
                              : (item.fee! + item.subtotal!)
                                  .toStringAsFixed(2))),
                    );
                  },
                  itemCount: state.requests.length,
                );
              } else {
                return Center(
                  child: Text('You do not have any transactions yet.'),
                );
              }
            }

            return Container();
          },
        ),
      ),
    );
  }
}
