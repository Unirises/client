import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:client/features/food_delivery/models/Merchant.dart';
import 'package:client/features/parcel/built_models/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'merchant_event.dart';
part 'merchant_state.dart';

class MerchantBloc extends Bloc<MerchantEvent, MerchantState> {
  MerchantBloc() : super(MerchantInitial());

  @override
  Stream<MerchantState> mapEventToState(
    MerchantEvent event,
  ) async* {
    if (event is FetchMerchants) {
      List<Merchant> listOfMerchants = [];

      try {
        yield MerchantLoading();
        var merchants =
            await FirebaseFirestore.instance.collection('merchants').get();

        merchants.docs.forEach((element) async {
          var company = await FirebaseFirestore.instance
              .collection('users')
              .doc(element.id)
              .get();

          var merchantData = element.data();
          var companyData = company.data();
          if (companyData['place'] != null) {
            var merchant = Merchant(
              address: companyData['address'],
              averageTimePreparation: companyData['averageTimePReparation'],
              companyName: companyData['companyName'],
              hero: companyData['hero'],
              photo: companyData['photo'],
              place: Location.fromJson(json.encode(companyData['place'])),
              startTime: companyData['startTime'],
              endTime: companyData['endTime'],
              listing: merchantData['listing'],
              phone: companyData['phone'],
              representative: companyData['representative'],
            );

            listOfMerchants.add(merchant);
          }
        });
        yield MerchantLoadSuccess(listOfMerchants);
      } catch (e) {
        print(e);
        yield MerchantLoadFailure();
      }
    }
  }
}
