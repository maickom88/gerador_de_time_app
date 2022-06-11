import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_commons/app/domain/entities/goal_entity.dart';
import 'package:micro_commons/app/domain/entities/match_entity.dart';
import 'package:micro_commons/app/domain/entities/team_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';

import '../usecases/initialize_cup.dart';
import '../usecases/initialize_match.dart';
import '../usecases/register_goal.dart';
import '../usecases/update_match.dart';
import '../usecases/update_team.dart';

abstract class ApiRepository {
  Future<Either<Failure, CupEntity>> initializeCup(CupParams params);
  Future<Either<Failure, TeamEntity>> updateTeam(UpdateTeamParams params);
  Future<Either<Failure, CupEntity>> getCup(String params);
  Future<Either<Failure, void>> removeGoal(String params);
  Future<Either<Failure, MatchEntity>> updateMatch(UpdateMatchParams params);
  Future<Either<Failure, GoalEntity>> registerGoal(GoalParams params);
  Future<Either<Failure, MatchEntity>> initializeMatch(MatchParams params);
}
