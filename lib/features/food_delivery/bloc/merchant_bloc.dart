import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../parcel/built_models/location.dart';
import '../models/Merchant.dart';
import '../models/merchant_listing.dart';

part 'merchant_event.dart';
part 'merchant_state.dart';

class MerchantBloc extends Bloc<MerchantEvent, MerchantState> {
  MerchantBloc() : super(MerchantInitial());

  @override
  Stream<MerchantState> mapEventToState(
    MerchantEvent event,
  ) async* {
    if (event is FetchMerchants) {
      try {
        yield MerchantLoading();
        var merchants =
            await FirebaseFirestore.instance.collection('merchants').get();
        List<Merchant> listOfMerchants = [];
        List<Map<String, dynamic>> companies = [];
        var company =
            await FirebaseFirestore.instance.collection('users').get();
        company.docs.forEach(
            (element) => companies.add({...element.data(), 'id': element.id}));

        merchants.docs.forEach((element) {
          var finalCompany = companies.firstWhere(
              (companyElement) => element.id == companyElement['id']);
          if (finalCompany['place'] != null) {
            try {
              var merchant = Merchant(
                id: element.id,
                address: finalCompany['address'],
                averageTimePreparation: finalCompany['averageTimePreparation'],
                companyName: finalCompany['companyName'],
                hero: finalCompany['hero'],
                photo: finalCompany['photo'],
                place: Location.fromJson(json.encode(finalCompany['place'])),
                startTime: finalCompany['startTime'],
                endTime: finalCompany['endTime'],
                listing: MerchantListing.fromJson(json.encode(element.data())),
                phone: finalCompany['phone'],
                representative: finalCompany['representative'],
              );
              log(merchant.listing.toString());

              listOfMerchants.add(merchant);
            } catch (e, stacktrace) {
              log(e.toString());
              log(stacktrace.toString());
              print('cannot add merchant ${element.id}');
            }
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
