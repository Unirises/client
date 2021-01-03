import 'package:formz/formz.dart';

enum PaymentEnum { wallet, cash }
enum PaymentValidationError { invalid }

class Payment extends FormzInput<PaymentEnum, PaymentValidationError> {
  const Payment.pure() : super.pure(PaymentEnum.cash);
  const Payment.dirty([
    PaymentEnum value = PaymentEnum.cash,
  ]) : super.dirty(value);

  @override
  PaymentValidationError validator(PaymentEnum value) {
    return PaymentEnum.values.contains(value)
        ? null
        : PaymentValidationError.invalid;
  }
}
