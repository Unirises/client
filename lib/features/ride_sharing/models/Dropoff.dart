import 'package:formz/formz.dart';

enum DropoffValidationError { invalid }

class Dropoff extends FormzInput<Map<String, dynamic>, DropoffValidationError> {
  const Dropoff.pure() : super.pure(const {});
  const Dropoff.dirty([Map<String, dynamic> value = const {}])
      : super.dirty(value);

  @override
  DropoffValidationError validator(Map<String, dynamic> value) {
    if (value.isNotEmpty) {
      if (value['address'] == null ||
          value['coordinates']['lat'] == null ||
          value['coordinates']['lng'] == null) {
        return DropoffValidationError.invalid;
      }
      return null;
    }
    return DropoffValidationError.invalid;
  }
}
