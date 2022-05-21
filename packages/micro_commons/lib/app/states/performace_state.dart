import 'package:micro_core/core/errors/errors.dart';

import '../domain/entities/performace_entity.dart';

abstract class PerformaceState {}

class PerformaceLoandingState extends PerformaceState {}

class InitialPerformaceState extends PerformaceState {}

class PerformaceSuccessState extends PerformaceState {
  final PerfomaceEntity perfomace;
  PerformaceSuccessState({
    required this.perfomace,
  });
}

class PerformaceErrorState extends PerformaceState {
  final Failure error;
  PerformaceErrorState({
    required this.error,
  });
}
