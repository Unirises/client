import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../core/authentication_bloc/authentication_bloc.dart';
import '../../../../core/client_bloc/client_bloc.dart';
import '../../../../core/splash_page.dart';
import '../../../../core/user_collection_bloc/user_collection_bloc.dart';
import '../../../account/presentation/pages/account_index_page.dart';
import '../../../food_delivery/presentation/pages/food_delivery_main_page.dart';
import '../../../parcel/presentation/pages/parcel_main_page.dart';

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
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      return Flushbar(
        title: (event.data['title'] != null)
            ? event.data['title']
            : 'Notification',
        message: (event.data['message'] != null)
            ? event.data['message']
            : 'You got a new notification',
        duration: Duration(seconds: 5),
        isDismissible: false,
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Theme.of(context).primaryColor,
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);
    });

    sendVerification();
  }

  sendVerification() async {
    if (!FirebaseAuth.instance.currentUser.emailVerified) {
      print('not verified');
      await FirebaseAuth.instance.currentUser.sendEmailVerification();
    } else {
      print('verified');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    if (user.name == null) {
      return SplashPage();
    }

    context.read<UserCollectionBloc>().add(FetchUserCollection());
    context.read<ClientBloc>().add(FetchClient());
    context.read<ClientBloc>().add(StartLocationUpdate());

    return BlocBuilder<UserCollectionBloc, UserCollectionState>(
      builder: (context, state) {
        if (state is UserCollectionLoaded)
          return PersistentTabView(
            context,
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
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle
                .style2, // Choose the nav bar style with this property.
          );
        return SplashPage();
      },
    );
  }

  List<Widget> _buildScreens() {
    return [PabiliMainPage(), FoodDeliveryMainPage(), AccountIndexPage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.archivebox),
        title: 'Parcel Delivery',
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.shopping_cart),
        title: 'Merchants',
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
