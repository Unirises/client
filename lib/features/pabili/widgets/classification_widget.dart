import 'package:flutter/material.dart';

import '../models/Categories.dart';

class ClassificationWidget extends StatelessWidget {
  final List<Categories> categories;

  const ClassificationWidget({Key key, this.categories}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> categoriesName = [];
    categories.forEach((element) {
      categoriesName.add(element.name);
    });
    return Text(
      categoriesName.join(', '),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );
  }
}
