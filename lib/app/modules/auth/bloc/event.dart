part of 'bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class ChangePhoneEvent extends AuthEvent {
  final String phone;
  const ChangePhoneEvent(this.phone);
}

class ChangeCodeEvent extends AuthEvent {
  final String code;
  const ChangeCodeEvent(this.code);
}

class SendCodeEvent extends AuthEvent {
  const SendCodeEvent();
}

class ValidateCodeEvent extends AuthEvent {
  const ValidateCodeEvent();
}
