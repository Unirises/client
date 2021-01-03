import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:user_repository/user_repository.dart';

import 'app_view.dart';
import 'core/Flavor.dart';
import 'core/authentication_bloc/authentication_bloc.dart';
import 'core/client_bloc/client_bloc.dart';
import 'core/client_bloc/client_repository.dart';
import 'core/initial_map_bloc/initial_map_bloc.dart';
import 'core/pabili_delivery/pabili_delivery_bloc.dart';
import 'core/pabili_delivery/pabili_delivery_repository.dart';
import 'core/requests_bloc/request_repository.dart';
import 'core/requests_bloc/requests_bloc.dart';
import 'core/ride_sharing_bloc/ride_sharing_bloc.dart';
import 'core/ride_sharing_bloc/ride_sharing_repository.dart';
import 'core/user_collection_bloc/user_collection_bloc.dart';
import 'features/pabili/blocs/cubit/checkout_cubit.dart';
import 'features/pabili/blocs/store/bloc/store_bloc.dart';
import 'features/pabili/repositories/store_repository.dart';
import 'features/ride_sharing/cubit/book_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  // Bloc.observer = SimpleBlocObserver();

  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userFirestoreRepository: UserFirestoreRepository(),
    clientRepository: ClientRepository(),
    rideSharingRepository: RideSharingRepository(),
    requestRepository: RequestRepository(),
    storeRepository: StoreRepository(),
    pabiliDeliveryRepository: PabiliDeliveryRepository(),
  ));
}

class App extends StatefulWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.userFirestoreRepository,
    @required this.clientRepository,
    @required this.rideSharingRepository,
    @required this.requestRepository,
    @required this.storeRepository,
    @required this.pabiliDeliveryRepository,
  })  : assert(
            authenticationRepository != null, userFirestoreRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserFirestoreRepository userFirestoreRepository;
  final ClientRepository clientRepository;
  final RideSharingRepository rideSharingRepository;
  final RequestRepository requestRepository;
  final StoreRepository storeRepository;
  final PabiliDeliveryRepository pabiliDeliveryRepository;

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
            create: (_) => InitialMapBloc(
              clientRepository: widget.clientRepository,
            ),
          ),
          BlocProvider(
            create: (_) => RideSharingBloc(
              rideSharingRepository: widget.rideSharingRepository,
            ),
          ),
          BlocProvider(
            create: (_) => RequestsBloc(
              requestRepository: widget.requestRepository,
            ),
          ),
          BlocProvider(
            create: (_) => StoreBloc(
              storeRepository: widget.storeRepository,
            ),
          ),
          BlocProvider(
            create: (_) => PabiliDeliveryBloc(
              repository: widget.pabiliDeliveryRepository,
            ),
          ),
          BlocProvider(
            create: (_) => BookCubit(),
          ),
          BlocProvider(
            create: (_) => CheckoutCubit(),
          ),
        ],
        child: Provider<Flavor>.value(value: Flavor.prod, child: AppView()),
      ),
    );
  }
}
