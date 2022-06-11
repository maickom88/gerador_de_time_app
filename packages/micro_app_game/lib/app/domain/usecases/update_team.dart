import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/team_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class UpdateTeam implements Usecase<UpdateTeamParams, TeamEntity> {
  final ApiRepository apiRepository;
  UpdateTeam({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, TeamEntity>> call(UpdateTeamParams params) async {
    return await apiRepository.updateTeam(params);
  }
}

class UpdateTeamParams {
  final String guid;
  final String name;
  final String color;
  final int victories;
  final int goals;
  final int goalsNegative;
  UpdateTeamParams({
    required this.guid,
    required this.name,
    required this.color,
    required this.victories,
    required this.goals,
    required this.goalsNegative,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'name': name,
      'color': color,
      'victories': victories,
      'goals': goals,
      'goals_negative': goalsNegative,
    };
  }
}
