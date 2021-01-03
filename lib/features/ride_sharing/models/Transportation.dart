import 'package:formz/formz.dart';

enum TransportationEnum { motorcycle, car2Seater, car4Seater, car7Seater }
enum TransportationValidationError { invalid }

class Transportation
    extends FormzInput<TransportationEnum, TransportationValidationError> {
  const Transportation.pure() : super.pure(TransportationEnum.motorcycle);
  const Transportation.dirty([
    TransportationEnum value = TransportationEnum.motorcycle,
  ]) : super.dirty(value);

  @override
  TransportationValidationError validator(TransportationEnum value) {
    return TransportationEnum.values.contains(value)
        ? null
        : TransportationValidationError.invalid;
  }
}
