import 'package:formz/formz.dart';

enum PlateValidationError { invalid }

class Plate extends FormzInput<String, PlateValidationError> {
  const Plate.pure() : super.pure('');
  const Plate.dirty([String value = '']) : super.dirty(value);

  @override
  PlateValidationError? validator(String value) {
    return value.isNotEmpty ? null : PlateValidationError.invalid;
  }
}
