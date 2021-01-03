import 'package:flutter/material.dart';

import '../models/Store.dart';
import 'classification_widget.dart';

class StoreListingItem extends StatelessWidget {
  final Store store;
  final num distance;
  const StoreListingItem({
    Key key,
    this.store,
    this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                (store.logo == null || store.logo == 'null')
                    ? Container()
                    : Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            store.logo,
                            fit: BoxFit.cover,
                            height: 75.0,
                          ),
                        ),
                      ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          store.location.place,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        (store.categories.isNotEmpty)
                            ? ClassificationWidget(categories: store.categories)
                            : Container(),
                        Text('${(distance / 1000).round()} km away'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
