import 'package:micro_core/core/errors/errors.dart';

import '../../domain/entities/auth_response.dart';

abstract class LoginState {}

class LoginLoandingState extends LoginState {}

class InitialLoginState extends LoginState {}

class LoginSuccessState extends LoginState {
  final AuthResponse success;

  LoginSuccessState({
    required this.success,
  });
}

class LoginErrorState extends LoginState {
  final Failure error;
  LoginErrorState({
    required this.error,
  });
}
