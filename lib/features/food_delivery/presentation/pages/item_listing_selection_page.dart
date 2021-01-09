import 'package:client/features/food_delivery/models/classification_listing.dart';
import 'package:flutter/material.dart';

class ItemListingSelectionPage extends StatelessWidget {
  final ClassificationListing item;
  final Function(ClassificationListing) onSuccess;

  const ItemListingSelectionPage({Key key, this.item, this.onSuccess})
      : super(key: key);
  // TODO: Implement
  @override
  Widget build(BuildContext context) {
    // TODO: create a validity check here

    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text(item.itemName),
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
                  children: item.additionals
                      .map((additionals) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  additionals.additionalName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32),
                                ),
                              ),
                              Text(additionals.type),
                              ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      print('tapped: ${item.additionals}');
                                      print(additionals.additionalName ==
                                          item.additionals[index]
                                              .additionalName);
                                    },
                                    title: Text(additionals
                                        .additionalListing[index].name),
                                    leading: Container(
                                      child: Text(additionals
                                                  .additionalListing[index]
                                                  .isSelected ??
                                              false
                                          ? 'Selected'
                                          : ''),
                                    ),
                                    subtitle: Text(
                                        '${additionals.additionalListing[index].isSelected} PHP ' +
                                            additionals.additionalListing[index]
                                                .additionalPrice
                                                .toStringAsFixed(2)),
                                  );
                                },
                                itemCount: additionals.additionalListing.length,
                              ),
                            ],
                          ))
                      .toList(),
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
                  onTap: (item.isValid != null)
                      ? (item.isValid)
                          ? () => onSuccess(item)
                          : null
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: (item.isValid != null)
                            ? (item.isValid)
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
