import 'package:micro_core/core/errors/errors.dart';

import '../../domain/entities/cup_information_entity.dart';

abstract class CupInformationState {}

class CupInformationLoandingState extends CupInformationState {}

class InitialCupInformationState extends CupInformationState {}

class CupInformationSuccessState extends CupInformationState {
  final CupInformationEntity cupInformation;
  CupInformationSuccessState({
    required this.cupInformation,
  });
}

class CupInformationErrorState extends CupInformationState {
  final Failure error;
  CupInformationErrorState({
    required this.error,
  });
}
