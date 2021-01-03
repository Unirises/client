import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'app_view.dart';
import 'bloc/authentication_bloc.dart';
import 'bloc/user_collection_bloc.dart';
import 'flavor_enum.dart';
import 'repository/authentication_repository.dart';
import 'repository/user_firestore_repository.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();

  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userFirestoreRepository: UserFirestoreRepository(),
  ));
}

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.userFirestoreRepository,
  })  : assert(
            authenticationRepository != null, userFirestoreRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserFirestoreRepository userFirestoreRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (_) => UserCollectionBloc(
              userFirestoreRepository: userFirestoreRepository,
            ),
          ),
        ],
        child: Provider<Flavor>.value(value: Flavor.prod, child: AppView()),
      ),
    );
  }
}
