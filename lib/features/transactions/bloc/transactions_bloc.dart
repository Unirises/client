import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:client/features/parcel/built_models/built_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:built_collection/built_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsInitial());

  @override
  Stream<TransactionsState> mapEventToState(
    TransactionsEvent event,
  ) async* {
    if (event is FetchTransactions) {
      var builtRequests = BuiltList<BuiltRequest>([]);
      yield TransactionsLoading();
      var rides = await FirebaseFirestore.instance
          .collection('clients')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('rides')
          .get();
      rides.docs.forEach((element) {
        var item = BuiltRequest.fromJson(json.encode(element.data()));
        if (item != null) {
          builtRequests = builtRequests.rebuild((b) => b..add(item));
        }
      });
      builtRequests = builtRequests.rebuild(
          (b) => b.sort((a, b) => b.timestamp!.compareTo(a.timestamp!)));
      yield TransactionsLoaded(builtRequests);
    }
  }
}
