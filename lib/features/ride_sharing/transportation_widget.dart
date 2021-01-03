import 'package:flutter/material.dart';

import 'models/TransportationModel.dart';

class AppTheme {
  static const TextStyle display1 = TextStyle(
    fontFamily: 'WorkSans',
    color: Colors.black,
    fontSize: 38,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );

  static const TextStyle display2 = TextStyle(
    fontFamily: 'WorkSans',
    color: Colors.black,
    fontSize: 32,
    fontWeight: FontWeight.normal,
    letterSpacing: 1.1,
  );

  static final TextStyle heading = TextStyle(
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w900,
    fontSize: 34,
    color: Colors.white.withOpacity(0.8),
    letterSpacing: 1.2,
  );

  static final TextStyle subHeading = TextStyle(
    inherit: true,
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w500,
    fontSize: 24,
    color: Colors.white.withOpacity(0.8),
  );
}

class TransportationModeWidget extends StatelessWidget {
  const TransportationModeWidget({
    Key key,
    this.transport,
    this.pageController,
    this.currentPage,
  }) : super(key: key);

  final TransportationModel transport;
  final PageController pageController;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        var value = 1.0;
        if (pageController.position.haveDimensions) {
          value = pageController.page - currentPage;
          value = (1.0 - (value.abs() * 0.6)).clamp(0.0, 1.0) as double;
        }

        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: CharacterCardBackgroundClipper(),
                child: Hero(
                  tag: 'background-${transport.name}',
                  child: Container(
                    height: 0.6 * screenHeight,
                    width: 0.9 * screenWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.yellow,
                          Theme.of(context).primaryColor,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, -0.5),
              child: Image.asset(
                transport.imagePath,
                height: screenHeight * 0.55 * value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: Container(
                      child: Text(
                        transport.name,
                        style: AppTheme.heading,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class CharacterCardBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var clippedPath = Path();
    const curveDistance = 40.0;

    return clippedPath
      ..moveTo(0, size.height * 0.4)
      ..lineTo(0, size.height - curveDistance)
      ..quadraticBezierTo(1, size.height - 1, 0 + curveDistance, size.height)
      ..lineTo(size.width - curveDistance, size.height)
      ..quadraticBezierTo(size.width + 1, size.height - 1, size.width,
          size.height - curveDistance)
      ..lineTo(size.width, 0 + curveDistance)
      ..quadraticBezierTo(size.width - 1, 0, size.width - curveDistance - 5,
          0 + curveDistance / 3)
      ..lineTo(curveDistance, size.height * 0.29)
      ..quadraticBezierTo(1, (size.height * 0.30) + 10, 0, size.height * 0.4);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
