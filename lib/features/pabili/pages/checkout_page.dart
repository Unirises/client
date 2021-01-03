import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/client_bloc/client_bloc.dart';
import '../../../core/pabili_delivery/pabili_delivery_bloc.dart';
import '../../../core/user_collection_bloc/user_collection_bloc.dart';
import '../../ride_sharing/models/Payment.dart';
import '../../ride_sharing/models/Transportation.dart';
import '../blocs/cubit/checkout_cubit.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
        }

        if (state.status.isSubmissionFailure) {
          Flushbar(
            title: 'An error occured',
            message: 'There has been an error',
          )..show(context);
        }
      },
      builder: (context, checkoutCubitState) {
        return BlocBuilder<UserCollectionBloc, UserCollectionState>(
          builder: (context, userCollectionState) {
            if (userCollectionState is UserCollectionLoaded) {
              return Scaffold(
                appBar: AppBar(
                  title: Column(
                    children: [
                      Text(checkoutCubitState.store.location.place),
                      (checkoutCubitState.pickupPoint != null)
                          ? Text(
                              'Distance from you: ${(checkoutCubitState.distance / 1000).round()} km (${(checkoutCubitState.duration / 60).round()} min)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  // color: Colors.grey,
                                  fontSize: 12))
                          : Container()
                    ],
                  ),
                  centerTitle: true,
                  actions: [
                    checkoutCubitState.status.isSubmissionInProgress
                        ? const AspectRatio(
                            aspectRatio: 1.0,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ))
                        : BlocBuilder<ClientBloc, ClientState>(
                            builder: (context, clientState) {
                              if (clientState is ClientLoaded) {
                                return FlatButton(
                                  onPressed: checkoutCubitState.status.isPure ||
                                          checkoutCubitState.status.isInvalid
                                      ? null
                                      : () => {
                                            if (checkoutCubitState
                                                    .payment.value ==
                                                PaymentEnum.cash)
                                              {
                                                context
                                                    .bloc<CheckoutCubit>()
                                                    .bookFormSubmitted(
                                                      clientBloc: context
                                                          .bloc<ClientBloc>(),
                                                      bloc: context.bloc<
                                                          PabiliDeliveryBloc>(),
                                                      phone: userCollectionState
                                                          .userCollection.phone,
                                                    )
                                              }
                                            else
                                              {
                                                if (clientState.client.balance <
                                                    (checkoutCubitState.fee +
                                                        checkoutCubitState
                                                            .subtotal))
                                                  {
                                                    Flushbar(
                                                      duration:
                                                          Duration(seconds: 5),
                                                      title:
                                                          "Not Enough Balance",
                                                      message:
                                                          'Your wallet does not have enough balance. Please cash in at least PHP ${(checkoutCubitState.fee + checkoutCubitState.subtotal) - clientState.client.balance}.',
                                                    )..show(context)
                                                  }
                                                else
                                                  {
                                                    context
                                                        .bloc<CheckoutCubit>()
                                                        .bookFormSubmitted(
                                                          clientBloc:
                                                              context.bloc<
                                                                  ClientBloc>(),
                                                          bloc: context.bloc<
                                                              PabiliDeliveryBloc>(),
                                                          phone:
                                                              userCollectionState
                                                                  .userCollection
                                                                  .phone,
                                                        )
                                                  }
                                              }
                                          },
                                  child: Text(
                                    'Book',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                  ],
                ),
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          showLocationPicker(
                            context,
                            'AIzaSyBWlDJm4CJ_PAhhrC0F3powcfmy_NJEn2E',
                            initialCenter: LatLng(14.6091, 121.0223),
                            automaticallyAnimateToCurrentLocation: true,
                            myLocationButtonEnabled: true,
                            requiredGPS: true,
                            countries: ['PH'],
                            desiredAccuracy: LocationAccuracy.best,
                          ).then((LocationResult value) {
                            var data = {
                              'address': value.address,
                              'coordinates': {
                                'lat': value.latLng.latitude,
                                'lng': value.latLng.longitude,
                              },
                            };
                            context
                                .bloc<CheckoutCubit>()
                                .pickupPointChanged(data);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                            padding: EdgeInsets.all(30),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(
                                checkoutCubitState.pickupPoint.value.isEmpty
                                    ? 'Deliver to location'
                                    : checkoutCubitState
                                        .pickupPoint.value['address']
                                        .toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Order Summary',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            // return Slidable(
                            //   actionPane: SlidableDrawerActionPane(),
                            //   key: Key(
                            //     checkoutCubitState.items[index].name +
                            //         '-' +
                            //         index.toString(),
                            //   ),
                            //   dismissal: SlidableDismissal(
                            //     child: SlidableDrawerDismissal(),
                            //     onDismissed: (actionType) {
                            //       context
                            //           .bloc<CheckoutCubit.CheckoutCubit>()
                            //           .removeItem(index);
                            //     },
                            //   ),
                            //   actions: [
                            //     IconSlideAction(
                            //       caption: 'Add',
                            //       color: Colors.green,
                            //       icon: Icons.add,
                            //       onTap: () {
                            //         context
                            //             .bloc<CheckoutCubit.CheckoutCubit>()
                            //             .addQuantity(index);
                            //       },
                            //     )
                            //   ],
                            //   secondaryActions: [
                            //     IconSlideAction(
                            //       caption: 'Remove',
                            //       color: Colors.red,
                            //       icon: Icons.remove,
                            //       onTap: () {
                            //         context
                            //             .bloc<CheckoutCubit.CheckoutCubit>()
                            //             .addQuantity(index);
                            //       },
                            //     )
                            //   ],
                            // );
                            return Slidable.builder(
                              key: Key(
                                checkoutCubitState.items[index].name +
                                    '-' +
                                    index.toString(),
                              ),
                              dismissal: SlidableDismissal(
                                child: SlidableDrawerDismissal(),
                                onDismissed: (actionType) {
                                  context
                                      .bloc<CheckoutCubit>()
                                      .removeItem(index);
                                },
                              ),
                              actionPane: SlidableDrawerActionPane(),
                              child: ListTile(
                                leading: Text(
                                    '${checkoutCubitState.items[index].quantity}x'),
                                subtitle: Text(
                                    '${checkoutCubitState.items[index].size != '0g' ? 'Size: ' + checkoutCubitState.items[index].size : ''}'),
                                title: Text(
                                    '${checkoutCubitState.items[index].name}'),
                                trailing: Text(
                                    '${checkoutCubitState.items[index].quantity * checkoutCubitState.items[index].price}'),
                                // trailing: FlatButton(
                                //   child: Text('Add'),
                                //   onPressed: () {
                                //     context
                                //         .bloc<CheckoutCubit.CheckoutCubit>()
                                //         .addQuantity(index,
                                //             checkoutCubitState.items[index].quantity);
                                //   },
                                // ),
                              ),
                              // actionDelegate: SlideActionBuilderDelegate(
                              //     actionCount: 2,
                              //     builder: (cxt, idx, animation, mode) {
                              //       return SlideAction(
                              //           onTap: () {
                              //             context
                              //                 .bloc<CheckoutCubit.CheckoutCubit>()
                              //                 .addQuantity(
                              //                     index,
                              //                     checkoutCubitState
                              //                         .items[index].quantity);
                              //           },
                              //           color: Colors.green,
                              //           child: Column(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.center,
                              //               children: [
                              //                 Icon(Icons.add, color: Colors.white),
                              //               ]));
                              //     }),
                              secondaryActionDelegate:
                                  SlideActionBuilderDelegate(
                                      actionCount: 1,
                                      builder: (cxt, index, animation, mode) {
                                        return SlideAction(
                                            onTap: () async {
                                              var state = Slidable.of(cxt);
                                              state.dismiss();
                                            },
                                            color: Colors.white10,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.delete,
                                                      color: Color(0xFFFF6984)),
                                                ]));
                                      }),
                            );
                          },
                          itemCount: checkoutCubitState.items.length,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                        ),
                        child: Text(
                          'Payment Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      BlocBuilder<CheckoutCubit, CheckoutState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Subtotal',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        'PHP ${checkoutCubitState.subtotal ?? 0}')
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: buildPriceWidget(
                                      state.fee, state.nonDiscountedFee),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        'PHP ${checkoutCubitState.fee + checkoutCubitState.subtotal}')
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButton<PaymentEnum>(
                                  value: checkoutCubitState.payment.value,
                                  onChanged: (PaymentEnum value) {
                                    context
                                        .bloc<CheckoutCubit>()
                                        .paymentChanged(value);
                                  },
                                  items: [
                                    DropdownMenuItem(
                                        value: PaymentEnum.cash,
                                        child: Row(
                                          children: [
                                            FaIcon(FontAwesomeIcons.moneyBill),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('Cash')
                                          ],
                                        )),
                                    DropdownMenuItem(
                                        value: PaymentEnum.wallet,
                                        child: Row(
                                          children: [
                                            FaIcon(FontAwesomeIcons.creditCard),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('Wallet')
                                          ],
                                        )),
                                  ]),
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            Expanded(
                              child: DropdownButton<TransportationEnum>(
                                  value:
                                      checkoutCubitState.transportation.value,
                                  onChanged: (TransportationEnum value) {
                                    context
                                        .bloc<CheckoutCubit>()
                                        .transportationChanged(value);
                                  },
                                  items: [
                                    DropdownMenuItem(
                                        value: TransportationEnum.car2Seater,
                                        child: Text('Sedan')),
                                    DropdownMenuItem(
                                        value: TransportationEnum.car4Seater,
                                        child: Text('SUV')),
                                    DropdownMenuItem(
                                        value: TransportationEnum.motorcycle,
                                        child: Text('Motorcycle')),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  List<Widget> buildPriceWidget(num fee, num discounted) {
    if (fee != discounted) {
      if (fee > discounted) {
        return [
          Text(
            'Delivery Fee',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(children: [
            Icon(
              Icons.trending_up_sharp,
              color: Colors.red,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              '₱ ${fee.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
            ),
          ]),
        ];
      }
      return [
        Text(
          'Delivery Fee',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Text(
              '₱ ${fee.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 8,
            ),
            Text('₱ ${discounted.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: TextStyle(decoration: TextDecoration.lineThrough)),
          ],
        ),
      ];
    }
    return [
      Text(
        'Delivery Fee',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        '₱ ${fee.toStringAsFixed(2)}',
        textAlign: TextAlign.center,
      ),
    ];
  }
}
