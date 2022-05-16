import 'package:micro_core/core/errors/errors.dart';

import '../../domain/entities/player_entity.dart';

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
