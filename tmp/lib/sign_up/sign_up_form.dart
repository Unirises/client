import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'cubit/sign_up_cubit.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.message ?? 'Registration Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Image.asset('assets/undraw/deliveries.png'),
                  ),
                  const Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Form(
                child: Column(
                  children: [
                    _NameInput(),
                    const SizedBox(height: 16),
                    _PhoneInput(),
                    const SizedBox(height: 16),
                    _EmailInput(),
                    const SizedBox(height: 16),
                    _PasswordInput(),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  _SignUpButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_nameInput_textField'),
          onChanged: (name) => context.bloc<SignUpCubit>().nameChanged(name),
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          keyboardType: TextInputType.name,
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
            labelText: 'Full Name',
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.all(18),
            errorText: state.name.invalid ? 'Invalid Name' : null,
          ),
        );
      },
    );
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_phoneInput_textField'),
          onChanged: (phone) => context.bloc<SignUpCubit>().phoneChanged(phone),
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          keyboardType: TextInputType.phone,
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
            labelText: 'Phone Number',
            hintText: '+639#########',
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.all(18),
            errorText: state.phone.invalid ? 'invalid phone' : null,
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.bloc<SignUpCubit>().emailChanged(email),
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          keyboardType: TextInputType.emailAddress,
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
            labelText: 'Email',
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.all(18),
            errorText: state.email.invalid ? 'Invalid Email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onSubmitted: (_) => FocusScope.of(context).unfocus(),
          onChanged: (password) =>
              context.bloc<SignUpCubit>().passwordChanged(password),
          obscureText: true,
          textInputAction: TextInputAction.done,
          style: const TextStyle(letterSpacing: 2),
          decoration: InputDecoration(
            labelStyle: const TextStyle(letterSpacing: 1),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            labelText: 'Password',
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.all(18),
            errorText: state.password.invalid ? 'Invalid Password' : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : InkWell(
                key: const Key('signUpForm_continue_raisedButton'),
                onTap: state.status.isValidated
                    ? () => context.bloc<SignUpCubit>().signUpFormSubmitted()
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
