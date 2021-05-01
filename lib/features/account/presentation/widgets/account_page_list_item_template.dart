import 'package:flutter/material.dart';

class AccountPageListItemTemplate extends StatelessWidget {
  const AccountPageListItemTemplate(
      {Key? key, required this.title, this.trailingText, this.onTap})
      : super(key: key);

  final String title;
  final String? trailingText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
          contentPadding: const EdgeInsets.all(0),
          onTap: onTap,
          title: Text(
            title,
          ),
          trailing: Wrap(
            spacing: 12, // space between two icons
            children: <Widget>[
              Text(
                trailingText ?? '',
                style: const TextStyle(color: Colors.grey),
              ),
              const Icon(Icons.arrow_forward_ios, size: 15),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
