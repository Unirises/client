import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../cubit/login_cubit.dart';
import '../widgets/email_input.dart';
import '../widgets/password_input.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(
        context.read<AuthenticationRepository>(),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white,
                body: BlocListener<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state.status.isSubmissionFailure) {
                      Flushbar(
                        flushbarPosition: FlushbarPosition.TOP,
                        title: 'Authentication Failure',
                        message: state.message,
                        duration: const Duration(seconds: 3),
                      )..show(context);
                    }
                  },
                  child: SafeArea(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.asset(
                                            'assets/undraw/game_day.png'),
                                      ),
                                      const Text(
                                        'Kumusta, \nkaibigan!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Form(
                                    child: Column(
                                      children: [
                                        EmailInput(),
                                        const SizedBox(height: 16),
                                        PasswordInput()
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  BlocBuilder<LoginCubit, LoginState>(
                                      builder: (context, state) {
                                    return state.status.isSubmissionInProgress
                                        ? const CircularProgressIndicator()
                                        : Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 24),
                                                    child: Text(
                                                      'Sign In',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 24,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () => state.status
                                                                .isInvalid ||
                                                            state.status.isPure
                                                        ? null
                                                        : context
                                                            .read<LoginCubit>()
                                                            .logInWithCredentials(),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor
                                                                .withAlpha(100),
                                                            blurRadius: 6.0,
                                                            spreadRadius: 0.0,
                                                            offset:
                                                                const Offset(
                                                              0.0,
                                                              3.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      child: const Padding(
                                                        padding: EdgeInsets.all(
                                                            14.0),
                                                        child: Icon(
                                                          Icons.navigate_next,
                                                          color: Colors.white,
                                                          size: 38,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TextButton.icon(
                                                  onPressed: () async {
                                                    print(state.email.status);
                                                    if (state.email.status ==
                                                            FormzInputStatus
                                                                .pure ||
                                                        state.email.status ==
                                                            FormzInputStatus
                                                                .invalid) {
                                                      return Flushbar(
                                                        title:
                                                            'Incomplete Form',
                                                        message:
                                                            'Please enter a valid email first at the field.',
                                                        flushbarPosition:
                                                            FlushbarPosition
                                                                .TOP,
                                                        duration: Duration(
                                                            seconds: 3),
                                                      )..show(context);
                                                    } else {
                                                      try {
                                                        await FirebaseAuth
                                                            .instance
                                                            .sendPasswordResetEmail(
                                                                email: state
                                                                    .email
                                                                    .value);
                                                        return Flushbar(
                                                          title: 'Success',
                                                          message:
                                                              'Forgot Password email sent at ${state.email.value}.',
                                                          flushbarPosition:
                                                              FlushbarPosition
                                                                  .TOP,
                                                          duration: Duration(
                                                              seconds: 3),
                                                        )..show(context);
                                                      } catch (e) {
                                                        return Flushbar(
                                                          title:
                                                              'Error Occured',
                                                          message:
                                                              '${e.message}',
                                                          flushbarPosition:
                                                              FlushbarPosition
                                                                  .TOP,
                                                          duration: Duration(
                                                              seconds: 3),
                                                        )..show(context);
                                                      }
                                                    }
                                                  },
                                                  icon: Icon(Icons.help_center),
                                                  label:
                                                      Text('Forgot Password')),
                                            ],
                                          );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Or Continue With'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BlocBuilder<LoginCubit, LoginState>(
                                  builder: (context, state) {
                                return RawMaterialButton(
                                  onPressed: () => context
                                      .read<LoginCubit>()
                                      .logInWithGoogle(),
                                  elevation: 0.0,
                                  child: FaIcon(
                                    FontAwesomeIcons.google,
                                    size: 20,
                                    color: Colors.grey[600],
                                  ),
                                  padding: const EdgeInsets.all(14.0),
                                  shape: const CircleBorder(
                                      side: BorderSide(color: Colors.grey)),
                                );
                              }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
