import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../blocs/cubit/checkout_cubit.dart';
import '../models/Categories.dart';
import '../models/Store.dart';

class ClassificationListing extends StatelessWidget {
  final Store store;
  final Categories category;
  const ClassificationListing({
    Key key,
    this.category,
    this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          var newList =
              category.listing.where((element) => element != null).toList();
          newList.sort((a, b) => a.price.compareTo(b.price));

          return ListView.builder(
            itemBuilder: (context, index) {
              return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  child: ListTile(
                    title: Row(
                      children: [
                        SizedBox(
                          height: (newList[index]?.photo == null ||
                                  newList[index]?.photo == 'null' ||
                                  newList[index]?.photo == '')
                              ? 0
                              : 75,
                          width: (newList[index]?.photo == null ||
                                  newList[index]?.photo == 'null' ||
                                  newList[index]?.photo == '')
                              ? 0
                              : 100,
                          child: (newList[index]?.photo == null ||
                                  newList[index]?.photo == 'null' ||
                                  newList[index]?.photo == '')
                              ? Container()
                              : Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      newList[index]?.photo,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${newList[index]?.name ?? 'NO ITEM NAME'}'),
                              Text(
                                'PHP ${newList[index].price}${newList[index].size != '0g' ? ' | Size: ' + newList[index].size : ''}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                        icon: Icons.add,
                        caption: 'Add',
                        color: Theme.of(context).primaryColor,
                        onTap: () {
                          context.read<CheckoutCubit>().addItem(
                                newList[index],
                                store,
                              );
                        }),
                  ]);
            },
            itemCount: newList.length,
          );
        },
      ),
    );
  }
}
