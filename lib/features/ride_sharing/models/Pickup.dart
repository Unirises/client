import 'package:formz/formz.dart';

enum PickupValidationError { invalid }

class Pickup extends FormzInput<Map<String, dynamic>, PickupValidationError> {
  const Pickup.pure() : super.pure(const {});
  const Pickup.dirty([Map<String, dynamic> value = const {}])
      : super.dirty(value);

  @override
  PickupValidationError validator(Map<String, dynamic> value) {
    if (value.isNotEmpty) {
      if (value['address'] == null ||
          value['coordinates']['lat'] == null ||
          value['coordinates']['lng'] == null) {
        return PickupValidationError.invalid;
      }
      return null;
    }
    return PickupValidationError.invalid;
  }
}
