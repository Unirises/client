import 'package:built_collection/built_collection.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/item_bloc.dart';
import '../../models/additionals.dart';
import '../../models/classification_listing.dart';

class ItemListingSelectionPage extends StatelessWidget {
  final int classificationIndex;
  final int itemIndex;
  final Function(ClassificationListing) onSuccess;

  const ItemListingSelectionPage({
    Key key,
    this.onSuccess,
    this.classificationIndex,
    this.itemIndex,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemBloc, ItemState>(builder: (ctx, state) {
      if (state is ItemLoadingInProgress) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is ItemLoadFailed) {
        return Scaffold(
          body: Center(
            child: Text('Item failed loading.'),
          ),
        );
      } else if (state is ItemLoaded) {
        return Scaffold(
          appBar: (state.item.itemPhoto != null)
              ? AppBar(
                  leading: CloseButton(),
                  title: Text(state.item.itemName),
                )
              : null,
          body: Stack(
            children: [
              Positioned(
                bottom: 130,
                left: 0,
                top: 0,
                right: 0,
                child: NestedScrollView(
                  physics: const BouncingScrollPhysics(),
                  headerSliverBuilder: (context, _) {
                    if (state.item.itemPhoto != null)
                      return [
                        SliverAppBar(
                          leading: Container(),
                          expandedHeight: 200.0,
                          floating: false,
                          pinned: false,
                          flexibleSpace: FlexibleSpaceBar(
                              stretchModes: [
                                StretchMode.zoomBackground,
                                StretchMode.blurBackground,
                              ],
                              background: state.item.itemPhoto != null
                                  ? Image.network(
                                      state.item.itemPhoto ??
                                          "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/default-hero.jpg',
                                      fit: BoxFit.cover,
                                    )),
                        ),
                      ];

                    return [
                      SliverAppBar(
                        title: Text(state.item.itemName),
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: buildAdditionals(state.item.additionals),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 6,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(28)),
                        color: Colors.white),
                    child: GestureDetector(
                      onTap: (state.item.isValid != null)
                          ? (state.item.isValid)
                              ? () => onSuccess(state.item)
                              : null
                          : null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => context.bloc<ItemBloc>().add(
                                      ItemQuantityUpdated(
                                          (state.item?.quantity ?? 0) - 1)),
                                  child: Icon(Icons.remove),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  state.item.quantity.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32),
                                ),
                                SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () => context.bloc<ItemBloc>().add(
                                      ItemQuantityUpdated(
                                          (state.item?.quantity ?? 0) + 1)),
                                  child: Icon(Icons.add),
                                ),
                                // Text(state.item.quantity?.toString() ??
                                //     0.toString()),
                                // IconButton(icon: Icon(Icons.add)),
                              ]),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 24, left: 24, right: 24),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: (state.item.isValid != null)
                                    ? (state.item.isValid)
                                        ? Colors.green
                                        : Colors.grey
                                    : Colors.grey,
                              ),
                              child: Center(
                                child: Text(
                                  'Add to basket - PHP ${(((state.additionalPrice != null && state.additionalPrice > 0) ? (state.item.itemPrice + state.additionalPrice) : state.item.itemPrice) * state.item.quantity).toStringAsFixed(2)}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              padding: const EdgeInsets.all(24),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }
    });
  }

  List<Widget> buildAdditionals(BuiltList<Additionals> additionals) {
    List<Widget> list = [];
    for (int i = 0; i < additionals.length; i++) {
      list.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  additionals[i].additionalName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
                buildMinMax(additionals[i].type, additionals[i].minMax.first,
                    additionals[i].minMax.last),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (ctx, index) {
              return ListTile(
                onTap: () {
                  // log('Classification: $classificationIndex | Item $itemIndex | Additional Index $i | Additional Listing Index $index');
                  List<ItemAdditionalUpdated> wow = [];
                  if (additionals[i].type == 'radio') {
                    for (int someRandomNum = 0;
                        someRandomNum < additionals[i].additionalListing.length;
                        someRandomNum++) {
                      if (someRandomNum == index) {
                        wow.add(ItemAdditionalUpdated(
                            classificationIndex, itemIndex, i, index, true));
                      } else {
                        print('not selected ${someRandomNum}');
                        wow.insert(
                            0,
                            ItemAdditionalUpdated(classificationIndex,
                                itemIndex, i, someRandomNum, false));
                      }
                    }
                  } else if (additionals[i].type == 'checkbox') {
                    int numOfSelected = additionals[i]
                        .additionalListing
                        .where((element) =>
                            element.isSelected != null &&
                            element.isSelected == true)
                        .length;
                    if (additionals[i].additionalListing[index].isSelected !=
                            null &&
                        additionals[i].additionalListing[index].isSelected ==
                            true) {
                      if (numOfSelected - 1 < additionals[i].minMax.first) {
                        return Flushbar(
                          title: 'Item Action',
                          message: 'You cannot delete.',
                          progressIndicatorBackgroundColor:
                              Theme.of(ctx).primaryColor,
                          flushbarPosition: FlushbarPosition.TOP,
                        )..show(ctx);
                      } else {
                        wow.insert(
                            0,
                            ItemAdditionalUpdated(classificationIndex,
                                itemIndex, i, index, false));
                        print('its trying to toggle it self dumbass');
                      }
                    } else if (numOfSelected + 1 > additionals[i].minMax.last) {
                      return Flushbar(
                        title: 'Item Action',
                        message: 'You cannot add more data',
                        duration: Duration(seconds: 5),
                        progressIndicatorBackgroundColor:
                            Theme.of(ctx).primaryColor,
                        flushbarPosition: FlushbarPosition.TOP,
                      )..show(ctx);
                    } else {
                      wow.insert(
                          0,
                          ItemAdditionalUpdated(
                              classificationIndex, itemIndex, i, index, true));
                    }
                  }

                  wow.forEach((element) {
                    ctx.bloc<ItemBloc>().add(element);
                  });
                },
                title: Text(additionals[i].additionalListing[index].name),
                trailing: Container(
                  child: Text(
                      additionals[i].additionalListing[index].isSelected ??
                              false
                          ? 'Selected'
                          : ''),
                ),
                subtitle: Text('PHP ' +
                    additionals[i]
                        .additionalListing[index]
                        .additionalPrice
                        .toStringAsFixed(2)),
              );
            },
            itemCount: additionals[i].additionalListing.length,
          ),
        ],
      ));
    }
    return list;
  }

  Text buildMinMax(String type, int min, int max) {
    if (type == 'radio') {
      return Text('Please select one of the following choices.');
    } else if (type == 'checkbox') {
      if (min == max) {
        return Text('Please select one of the following choices.');
      }
      if (min == 0) {
        return Text('You could select up to ${max} choices.');
      }
      return Text(
          'You could select up to ${max} of the choices, with minimum of ${min} item/s.');
    } else {
      return Text('Unknown type of selection');
    }
  }
}
