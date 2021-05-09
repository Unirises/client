import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

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
              bool isAvailable = false;

              List<String>? startTimeTmp = [];
              List<String> startTimeList = [];
              startTimeTmp = finalCompany['startTime'].split(" ");
              startTimeList = startTimeTmp![0].split(":");

              List<String>? endTimeTmp = [];
              List<String> endTimeList = [];
              endTimeTmp = finalCompany['endTime'].split(" ");
              endTimeList = endTimeTmp![0].split(":");

              var startTime = DateTime.now().copyWith(
                hour: (startTimeTmp[1].contains('AM'))
                    ? int.parse(startTimeList[0])
                    : int.parse(startTimeList[0]) + 12,
                minute: int.parse(endTimeList[1]),
              );

              var endTime = DateTime.now().copyWith(
                hour: (endTimeTmp[1].contains('AM'))
                    ? int.parse(endTimeList[0])
                    : int.parse(endTimeList[0]) + 12,
                minute: int.parse(endTimeList[1]),
              );

              if (DateTime.now().isAfter(startTime) &&
                  DateTime.now().isBefore(endTime)) {
                isAvailable = true;
              }
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
                isOpen: isAvailable,
              );
              listOfMerchants.add(merchant);
            } catch (e, stacktrace) {
              log(e.toString());
              log(stacktrace.toString());
              print('cannot add merchant ${element.id}');
            }
          }
        });

        yield MerchantLoadSuccess(listOfMerchants);
      } catch (e, st) {
        await FirebaseCrashlytics.instance.recordError(
          e,
          st,
          reason: 'Merchant Load Failure',
        );
        yield MerchantLoadFailure();
      }
    }
  }
}

extension MyDateUtils on DateTime {
  DateTime copyWith(
      {int? year,
      int? month,
      int? day,
      int? hour,
      int? minute,
      int? second,
      int? millisecond,
      int? microsecond}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}
