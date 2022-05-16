import 'package:micro_core/core/errors/errors.dart';

import '../../domain/entities/position_entity.dart';

abstract class PositionState {}

class PositionLoandingState extends PositionState {}

class InitialPositionState extends PositionState {}

class PositionSuccessState extends PositionState {
  final List<PositionEntity> positions;
  PositionSuccessState({
    required this.positions,
  });
}

class PositionErrorState extends PositionState {
  final Failure error;
  PositionErrorState({
    required this.error,
  });
}
