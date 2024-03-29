import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:formz/formz.dart';

import '../../../../core/models/Email.dart';
import '../../../../core/models/Name.dart';
import '../../../../core/models/Password.dart';
import '../../../../core/models/Phone.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository) : super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name, state.phone, state.email, state.password]),
    ));
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([state.name, phone, state.email, state.password]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.name, state.phone, email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.name, state.phone, state.email, password]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUpWithEmailAndPassword(
        name: state.name.value,
        phone: state.phone.value,
        email: state.email.value,
        password: state.password.value,
        isRider: false,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e, st) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        st,
        reason: 'Failed signing up.',
      );
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        message: e.toString().replaceAll("Exception: ", ""),
      ));
    }
  }
}
