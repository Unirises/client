part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const Name.pure(),
    this.phone = const Phone.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.message,
  });

  final Name name;
  final Phone phone;
  final Email email;
  final Password password;
  final FormzStatus status;
  final String message;

  @override
  List<Object> get props => [name, phone, email, password, status, message];

  SignUpState copyWith({
    Name name,
    Phone phone,
    Email email,
    Password password,
    FormzStatus status,
    String message,
  }) {
    return SignUpState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
