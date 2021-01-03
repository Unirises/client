import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Item extends Equatable {
  final String name;
  final String photo;
  final num price;
  final String size;
  final int quantity;

  const Item({
    @required this.name,
    this.photo,
    this.price,
    this.size,
    this.quantity,
  });

  static List<Item> fromListing(List<dynamic> data) {
    return data.map((e) => Item.fromSingleData(e)).toList();
  }

  static Item fromSingleData(Map<String, dynamic> data) {
    var x;

    if (data['itemPrice'] is String) {
      x = data['itemPrice'].replaceAll(',', '');
    } else {
      x = data['itemPrice'];
    }

    if (data['itemPrice'] != null) {
      try {
        return Item(
          name: data['itemName'],
          photo: data['itemPhoto'],
          price: num.parse(x.toString()),
          size: data['itemSize'],
          quantity: 1,
        );
      } catch (e) {}
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  @override
  List<Object> get props => [name, photo, price, size];

  Item copyWith({int quantity}) {
    return Item(
      name: name,
      photo: photo,
      price: price,
      size: size,
      quantity: this.quantity ?? quantity,
    );
  }
}
