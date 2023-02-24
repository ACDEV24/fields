part of 'bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  final Model model;
  const AuthState(this.model);

  @override
  List<Object> get props => [model];
}

class InitialState extends AuthState {
  const InitialState(Model model) : super(model);
}

class ChangedPhoneState extends AuthState {
  const ChangedPhoneState(Model model) : super(model);
}

class SendingCodeState extends AuthState {
  const SendingCodeState(Model model) : super(model);
}

class SendedCodeState extends AuthState {
  const SendedCodeState(Model model) : super(model);
}

class ErrorSendingCodeState extends AuthState {
  const ErrorSendingCodeState(Model model) : super(model);
}

class ValidatingCodeState extends AuthState {
  const ValidatingCodeState(Model model) : super(model);
}

class CodeValidatedState extends AuthState {
  const CodeValidatedState(Model model) : super(model);
}

class ErrorValidatingCodeState extends AuthState {
  const ErrorValidatingCodeState(Model model) : super(model);
}

class LoginWithGoogleState extends AuthState {
  const LoginWithGoogleState(Model model) : super(model);
}

class LoggedWithGoogleState extends AuthState {
  const LoggedWithGoogleState(Model model) : super(model);
}

class ErrorLoginWithGoogleState extends AuthState {
  const ErrorLoginWithGoogleState(Model model) : super(model);
}

class LoginOutWithGoogleState extends AuthState {
  const LoginOutWithGoogleState(Model model) : super(model);
}

class LoggedOutWithGoogleState extends AuthState {
  const LoggedOutWithGoogleState(Model model) : super(model);
}

class ErrorLoginOutWithGoogleState extends AuthState {
  const ErrorLoginOutWithGoogleState(Model model) : super(model);
}

class Model extends Equatable {
  final String phone;
  final String code;
  final User? user;

  const Model({
    this.phone = '',
    this.code = '',
    this.user,
  });

  Model copyWith({
    String? phone,
    String? code,
    User? user,
  }) {
    return Model(
      phone: phone ?? this.phone,
      code: code ?? this.code,
      user: user ?? this.user,
    );
  }

  bool get isPhoneValid => phone.length == 10;
  bool get isCodeValid => code.length == 4;

  @override
  List<Object?> get props {
    return [
      phone,
      code,
      user,
    ];
  }
}
