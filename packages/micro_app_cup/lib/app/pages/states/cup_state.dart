import 'package:micro_commons/app/entities/player_entity.dart';
import 'package:micro_core/core/errors/errors.dart';

abstract class CupState {}

class CupLoandingState extends CupState {}

class InitialCupState extends CupState {}

class CupSuccessState extends CupState {
  final List<PlayerEntity> players;
  CupSuccessState({
    required this.players,
  });
}

class CupErrorState extends CupState {
  final Failure error;
  CupErrorState({
    required this.error,
  });
}
