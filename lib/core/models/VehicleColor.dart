import 'package:formz/formz.dart';

enum VehicleColorValidationError { invalid }

class VehicleColor extends FormzInput<String, VehicleColorValidationError> {
  const VehicleColor.pure() : super.pure('');
  const VehicleColor.dirty([String value = '']) : super.dirty(value);

  @override
  VehicleColorValidationError validator(String value) {
    return value.isNotEmpty ? null : VehicleColorValidationError.invalid;
  }
}
