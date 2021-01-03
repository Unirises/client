import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/Flavor.dart';
import '../../../core/client_bloc/client_bloc.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        backgroundColor: Colors.white,
        title: Text('Wallet'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Center(child: BlocBuilder<ClientBloc, ClientState>(
                builder: (context, state) {
                  if (state is ClientLoaded) {
                    return Text(
                      'PHP ${state.client.balance.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return Text('Loading...');
                },
              ))),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    if (Provider.of<Flavor>(context, listen: false) ==
                        Flavor.dev) {
                      return await launch(
                          'https://buzz-staging-cfbae.web.app/app/top-up');
                    }
                    return await launch('https://buzzph.online/app/top-up');
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(width: 1.0, color: Colors.grey),
                        ),
                        child: Icon(
                          Icons.attach_money,
                          size: 25,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Cash In',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              'Cash Ins',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.grey,
              ),
            ),
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('transactions')
                .where(
                  'receiver',
                  isEqualTo: FirebaseAuth.instance.currentUser.uid,
                )
                .get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // var listOfCashIns = snapshot.data['documents'].map();
                  var listOfCashIns = snapshot.data.docs.map((e) {
                    var data = e.data();
                    if (data['sender'] == 'paypal') {
                      if (data['timestamp'] != null) {
                        return e.data();
                      }
                    }
                  }).toList();

                  listOfCashIns = listOfCashIns
                      .where((element) => element != null)
                      .toList();

                  if (listOfCashIns.length > 0) {
                    listOfCashIns.sort(
                        (b, a) => a['timestamp'].compareTo(b['timestamp']));
                  }

                  if (listOfCashIns.length > 0) {
                    return Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  'PayPal Cash In - ${listOfCashIns[index]['status'].toString().capitalize()}'),
                              subtitle: Text(
                                  '${DateFormat('E, d y h:mm a').format(DateTime.fromMillisecondsSinceEpoch(listOfCashIns[index]['timestamp']))}'),
                              trailing: Text(
                                  'PHP ${listOfCashIns[index]['amount'].toString()}'),
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
                          itemCount: listOfCashIns.length),
                    );
                  } else {
                    return Text('No Transactions');
                  }
                }
              } else {
                return Text('No Transactions');
              }
            },
          )
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
