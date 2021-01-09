import 'dart:developer';

import 'package:client/features/food_delivery/bloc/item_bloc.dart';
import 'package:client/features/food_delivery/models/additionals.dart';
import 'package:client/features/food_delivery/models/classification_listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:built_collection/built_collection.dart';

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
          appBar: AppBar(
            leading: CloseButton(),
            title: Text(state.item.itemName),
          ),
          body: Stack(
            children: [
              Positioned(
                  bottom: 130,
                  left: 0,
                  top: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: buildAdditionals(state.item.additionals),
                      // children: state.item.additionals.map((additionals) {
                      //   return Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.all(18.0),
                      //         child: Text(
                      //           additionals.additionalName,
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.bold, fontSize: 32),
                      //         ),
                      //       ),
                      //       Text(additionals.type),
                      //       ListView.builder(
                      //         shrinkWrap: true,
                      //         itemBuilder: (ctx, index) {
                      //           return ListTile(
                      //             onTap: () {
                      //               // TODO: Get item index
                      //               log('Classification: $classificationIndex | Item $itemIndex | Additional Index null | Additional Listing Index $index');
                      //             },
                      //             title: Text(additionals
                      //                 .additionalListing[index].name),
                      //             leading: Container(
                      //               child: Text(additionals
                      //                           .additionalListing[index]
                      //                           .isSelected ??
                      //                       false
                      //                   ? 'Selected'
                      //                   : ''),
                      //             ),
                      //             subtitle: Text(
                      //                 '${additionals.additionalListing[index].isSelected} PHP ' +
                      //                     additionals.additionalListing[index]
                      //                         .additionalPrice
                      //                         .toStringAsFixed(2)),
                      //           );
                      //         },
                      //         itemCount: additionals.additionalListing.length,
                      //       ),
                      //     ],
                      //   );
                      // }).toList(),
                    ),
                  )),
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
                                  'Add',
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
            child: Text(
              additionals[i].additionalName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ),
          Text(additionals[i].type),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return ListTile(
                onTap: () {
                  // TODO: Get item index
                  log('Classification: $classificationIndex | Item $itemIndex | Additional Index $i | Additional Listing Index $index');
                },
                title: Text(additionals[i].additionalListing[index].name),
                leading: Container(
                  child: Text(
                      additionals[i].additionalListing[index].isSelected ??
                              false
                          ? 'Selected'
                          : ''),
                ),
                subtitle: Text(
                    '${additionals[i].additionalListing[index].isSelected} PHP ' +
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
}
