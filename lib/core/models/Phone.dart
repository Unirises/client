import 'package:formz/formz.dart';

enum PhoneValidationError { invalid }

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');
  const Phone.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneRegExp = RegExp(r'^(09|\+639)\d{9}$');

  @override
  PhoneValidationError? validator(String value) {
    return _phoneRegExp.hasMatch(value) ? null : PhoneValidationError.invalid;
  }
}
