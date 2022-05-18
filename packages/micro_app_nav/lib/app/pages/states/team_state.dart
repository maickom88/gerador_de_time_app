import 'package:micro_commons/app/entities/player_entity.dart';
import 'package:micro_core/core/errors/errors.dart';

abstract class TeamState {}

class TeamLoandingState extends TeamState {}

class InitialTeamState extends TeamState {}

class TeamSuccessState extends TeamState {
  final List<PlayerEntity> players;
  TeamSuccessState({
    required this.players,
  });
}

class TeamErrorState extends TeamState {
  final Failure error;
  TeamErrorState({
    required this.error,
  });
}
