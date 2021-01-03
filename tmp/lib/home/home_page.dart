import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jg_express_client/restaurants/bloc/restaurants_bloc.dart';
import 'package:jg_express_client/restaurants/restaurants_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../account/index.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/user_collection_bloc.dart';
import '../splash_page.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.bloc<AuthenticationBloc>().state.user;
    if (user.name == null) {
      return SplashPage();
    }
    context.bloc<UserCollectionBloc>().add(FetchUserCollection());
    return BlocBuilder<UserCollectionBloc, UserCollectionState>(
      builder: (context, state) {
        if (state is UserCollectionLoaded)
          return PersistentTabView(
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.white,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            itemAnimationProperties: const ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style1,
          );
        return SplashPage();
      },
    );
  }

  List<Widget> _buildScreens() {
    return [MapSample(), RestaurantsPage(), AccountIndexPage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: 'Home',
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart),
        title: 'Restaurants',
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: 'Account',
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: CupertinoColors.systemGrey,
      ),
    ];
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCollectionBloc, UserCollectionState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(state.userCollection.position.latitude,
                        state.userCollection.position.longitude),
                    zoom: 15),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              Positioned(
                bottom: 15,
                child: Container(
                  color: Colors.white,
                  child: const Text('hello'),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
