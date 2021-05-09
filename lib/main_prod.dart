import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

import 'app_view.dart';
import 'core/Flavor.dart';
import 'core/authentication_bloc/authentication_bloc.dart';
import 'core/client_bloc/client_bloc.dart';
import 'core/client_bloc/client_repository.dart';
import 'core/user_collection_bloc/user_collection_bloc.dart';
import 'features/food_delivery/bloc/checkout_bloc.dart';
import 'features/food_delivery/bloc/food_ride_bloc.dart';
import 'features/food_delivery/bloc/item_bloc.dart';
import 'features/food_delivery/bloc/merchant_bloc.dart';
import 'features/parcel/bloc/parcel_bloc.dart';
import 'features/parcel/bloc/parcel_ride_bloc.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message ${message.messageId}");
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

/// Initalize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  // Bloc.observer = SimpleBlocObserver();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userFirestoreRepository: UserFirestoreRepository(),
    clientRepository: ClientRepository(),
  ));
}

class App extends StatefulWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userFirestoreRepository,
    required this.clientRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserFirestoreRepository userFirestoreRepository;
  final ClientRepository clientRepository;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    getPerms();
  }

  getPerms() async {
    return await Geolocator.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: widget.authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (_) => UserCollectionBloc(
              userFirestoreRepository: widget.userFirestoreRepository,
            ),
          ),
          BlocProvider(
            create: (_) => ClientBloc(
              clientRepository: widget.clientRepository,
            ),
          ),
          BlocProvider(
            create: (_) => MerchantBloc(),
          ),
          BlocProvider(
              create: (_) =>
                  ParcelBloc(clientRepository: widget.clientRepository)),
          BlocProvider(create: (_) => ParcelRideBloc()),
          BlocProvider(create: (_) => FoodRideBloc()),
          BlocProvider(
            create: (_) => ItemBloc(),
          ),
          BlocProvider(
            create: (_) =>
                CheckoutBloc(clientRepository: widget.clientRepository),
          ),
        ],
        child: Provider<Flavor>.value(value: Flavor.prod, child: AppView()),
      ),
    );
  }
}
