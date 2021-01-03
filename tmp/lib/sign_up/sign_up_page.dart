import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/authentication_repository.dart';
import 'cubit/sign_up_cubit.dart';
import 'sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: BlocProvider<SignUpCubit>(
                create: (_) => SignUpCubit(
                  context.repository<AuthenticationRepository>(),
                ),
                child: SignUpForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
