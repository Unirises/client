import 'package:flutter/material.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({Key key, this.url, this.radius})
      : super(key: key);

  final String url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0.5,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: radius ?? 40,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(
          url == null
              ? 'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'
              : url,
        ),
      ),
    );
  }
}
