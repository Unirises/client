import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'cubit/login_cubit.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.bloc<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.all(18),
            labelText: 'Email Address',
            errorText: state.email.invalid ? 'Invalid Email' : null,
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.bloc<LoginCubit>().passwordChanged(password),
          obscureText: true,
          onSubmitted: (_) => FocusScope.of(context).unfocus(),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.all(18),
            labelText: 'Password',
            errorText: state.password.invalid ? 'Invalid Password' : null,
          ),
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : InkWell(
                key: const Key('loginForm_continue_raisedButton'),
                onTap: state.status.isValidated
                    ? () => context.bloc<LoginCubit>().logInWithCredentials()
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withAlpha(100),
                        blurRadius: 6.0,
                        spreadRadius: 0.0,
                        offset: const Offset(0.0, 3.0),
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                      size: 38,
                    ),
                  ),
                ),
              );
      },
    );
  }
}
