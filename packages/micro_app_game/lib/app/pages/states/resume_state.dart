import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_core/core/errors/errors.dart';

abstract class ResumeState {}

class ResumeLoandingState extends ResumeState {}

class InitialResumeState extends ResumeState {}

class ResumeSuccessState extends ResumeState {
  final CupEntity cup;
  ResumeSuccessState({
    required this.cup,
  });
}

class ResumeErrorState extends ResumeState {
  final Failure error;
  ResumeErrorState({
    required this.error,
  });
}
