import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_commons/app/domain/entities/goal_entity.dart';
import 'package:micro_commons/app/domain/entities/match_entity.dart';
import 'package:micro_commons/app/domain/entities/team_entity.dart';

import '../../domain/usecases/initialize_cup.dart';
import '../../domain/usecases/initialize_match.dart';
import '../../domain/usecases/register_goal.dart';
import '../../domain/usecases/update_match.dart';
import '../../domain/usecases/update_team.dart';

abstract class ApiDatasource {
  Future<CupEntity> initializeCup(CupParams params);
  Future<CupEntity> getCup(String params);
  Future<CupEntity> finishCup(String params);
  Future<MatchEntity> initializeMatch(MatchParams params);
  Future<MatchEntity> updateMatch(UpdateMatchParams params);
  Future<GoalEntity> registerGoal(GoalParams params);
  Future<void> removeGoal(String params);
  Future<TeamEntity> updateTeam(UpdateTeamParams params);
}
