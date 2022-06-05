import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/team_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class RegisterTeam implements Usecase<RegisterTeamParams, TeamEntity> {
  final ApiRepository apiRepository;
  RegisterTeam({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, TeamEntity>> call(RegisterTeamParams params) async {
    return await apiRepository.registerTeam(params);
  }
}

class RegisterTeamParams {
  final String? guid;
  final String name;
  final String color;
  final int victories;
  final int goals;
  final int goalsNegative;
  final List<String> guidPlayers;
  RegisterTeamParams({
    this.guid,
    required this.name,
    required this.color,
    this.victories = 0,
    this.goals = 0,
    this.goalsNegative = 0,
    required this.guidPlayers,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'name': name,
      'color': color,
      'victories': victories,
      'goals': goals,
      'goals_negative': goalsNegative,
      'guid_players': guidPlayers,
    };
  }

  String toJson() => json.encode(toMap());
}
