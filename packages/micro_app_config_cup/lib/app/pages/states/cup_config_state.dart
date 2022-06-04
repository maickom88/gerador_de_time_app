import 'package:micro_core/core/errors/errors.dart';

abstract class CupConfigState {}

class CupConfigLoandingState extends CupConfigState {}

class InitialCupConfigState extends CupConfigState {}

class CupConfigSuccessState extends CupConfigState {}

class CupConfigErrorState extends CupConfigState {
  final Failure error;
  CupConfigErrorState({
    required this.error,
  });
}
