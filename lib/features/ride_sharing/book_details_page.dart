import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/client_bloc/client_bloc.dart';
import '../../core/ride_sharing_bloc/ride_sharing_bloc.dart';
import '../../core/user_collection_bloc/user_collection_bloc.dart';
import 'cubit/book_cubit.dart';
import 'models/Payment.dart';
import 'models/Transportation.dart';
import 'models/TransportationModel.dart';
import 'transportation_widget.dart';
import 'widgets/map_selection_button.dart';

class BookDetails extends StatefulWidget {
  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        viewportFraction: 1.0, initialPage: currentPage, keepPage: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            BlocConsumer<BookCubit, BookState>(
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
              builder: (context, state) {
                return BlocBuilder<ClientBloc, ClientState>(
                  builder: (context, clientState) {
                    if (clientState is ClientLoaded) {
                      return BlocBuilder<UserCollectionBloc,
                              UserCollectionState>(
                          builder: (context, userCollectionState) {
                        if (userCollectionState is UserCollectionLoaded) {
                          return state.status.isSubmissionInProgress
                              ? const AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: CircularProgressIndicator(),
                                  ))
                              : FlatButton(
                                  onPressed: () => state.status.isInvalid ||
                                          state.status.isPure
                                      ? null
                                      : {
                                          if (state.payment.value ==
                                              PaymentEnum.cash)
                                            {
                                              context
                                                  .bloc<BookCubit>()
                                                  .bookFormSubmitted(
                                                    context.bloc<ClientBloc>(),
                                                    context.bloc<
                                                        RideSharingBloc>(),
                                                    userCollectionState
                                                        .userCollection.phone,
                                                  )
                                            }
                                          else
                                            {
                                              if (clientState.client.balance <
                                                  state.total)
                                                {
                                                  Flushbar(
                                                    duration:
                                                        Duration(seconds: 5),
                                                    title: "Not Enough Balance",
                                                    message:
                                                        'Your wallet does not have enough balance. Please cash in at least PHP ${state.total - clientState.client.balance}.',
                                                  )..show(context)
                                                }
                                              else
                                                {
                                                  context
                                                      .bloc<BookCubit>()
                                                      .bookFormSubmitted(
                                                        context
                                                            .bloc<ClientBloc>(),
                                                        context.bloc<
                                                            RideSharingBloc>(),
                                                        userCollectionState
                                                            .userCollection
                                                            .phone,
                                                      )
                                                }
                                            }
                                        },
                                  textColor: state.status.isInvalid ||
                                          state.status.isPure
                                      ? Colors.grey
                                      : Colors.black,
                                  child: const Text(
                                    'Book',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                        }
                        return Container();
                      });
                    }
                    return CircularProgressIndicator();
                  },
                );
              },
            ),
          ],
        ),
        body: Container(
            child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.radio_button_checked,
                            color: Colors.black,
                          ),
                          Dash(
                              direction: Axis.vertical,
                              length: 45,
                              dashLength: 5,
                              dashThickness: 3.0,
                              dashColor: Colors.grey[400]),
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: BlocBuilder<BookCubit, BookState>(
                          buildWhen: (previousState, state) {
                            return (previousState.pickupPoint !=
                                    state.pickupPoint ||
                                previousState.dropoffPoint !=
                                    state.dropoffPoint);
                          },
                          builder: (context, state) {
                            return FutureBuilder(
                              future: Geolocator.getCurrentPosition(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (!snapshot.hasError) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: MapSelectionButton(
                                            cubit: context.bloc<BookCubit>(),
                                            isPickup: true,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          child: MapSelectionButton(
                                            cubit: context.bloc<BookCubit>(),
                                            isPickup: false,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: BlocBuilder<BookCubit, BookState>(
                builder: (context, state) {
                  return PageView(
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (val) {
                      context.bloc<BookCubit>().transportationChanged(
                          TransportationEnum.values[val]);
                    },
                    controller: _pageController,
                    children: <Widget>[
                      for (var i = 0; i < transportationModels.length; i++)
                        TransportationModeWidget(
                          transport: transportationModels[i],
                          pageController: _pageController,
                          currentPage: state.transportation.value.index,
                        )
                    ],
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: BlocBuilder<BookCubit, BookState>(
                builder: (context, state) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: ListTileTheme(
                              contentPadding: EdgeInsets.all(0),
                              child: CheckboxListTile(
                                value: state.isParcel,
                                onChanged: (value) {
                                  context
                                      .bloc<BookCubit>()
                                      .parcelChanged(value);
                                },
                                title: Text(
                                  'Parcel',
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: DropdownButton<PaymentEnum>(
                                value: state.payment.value,
                                onChanged: (PaymentEnum value) {
                                  context
                                      .bloc<BookCubit>()
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
                          Expanded(
                            child: buildPrices(
                              state.total,
                              state.nonDiscountedTotal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        )));
  }

  Widget buildPrices(num total, num nonDiscountedTotal) {
    if (total != nonDiscountedTotal) {
      if (total > nonDiscountedTotal) {
        return Row(
          children: [
            Icon(
              Icons.trending_up_sharp,
              color: Colors.red,
            ),
            Text(
              '₱ ${total.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '₱ ${total.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text('₱ ${nonDiscountedTotal.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: TextStyle(decoration: TextDecoration.lineThrough)),
        ],
      );
    } else {
      return Text(
        '₱ ${total.toStringAsFixed(2)}',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      );
    }
  }
}
