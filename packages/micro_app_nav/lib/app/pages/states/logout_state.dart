import 'package:micro_core/core/errors/errors.dart';

abstract class LogoutState {}

class LogoutLoandingState extends LogoutState {}

class InitialLogoutState extends LogoutState {}

class LogoutSuccessState extends LogoutState {}

class LogoutErrorState extends LogoutState {
  final Failure error;
  LogoutErrorState({
    required this.error,
  });
}
