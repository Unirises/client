import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'Item.dart';

class Categories extends Equatable {
  final String name;
  final List<Item> listing;

  const Categories({
    @required this.name,
    @required this.listing,
  });

  static List<Categories> fromListing(List<dynamic> data) {
    return data.map((e) => Categories.fromSingleData(e)).toList();
  }

  static Categories fromSingleData(Map<String, dynamic> data) {
    return Categories(
      name: data['classificationName'],
      listing: Item.fromListing(data['classificationListing']),
    );
  }

  @override
  List<Object> get props => [name, listing];
}
