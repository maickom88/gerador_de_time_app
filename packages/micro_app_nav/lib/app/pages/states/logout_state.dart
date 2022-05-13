import 'package:micro_core/core/errors/errors.dart';

abstract class LogoutState {}

class LogoutLoandingState extends LogoutState {}

class InitialLogoutStateState extends LogoutState {}

class LogoutStateSuccessState extends LogoutState {}

class LogoutStateErrorState extends LogoutState {
  final Failure error;
  LogoutStateErrorState({
    required this.error,
  });
}
