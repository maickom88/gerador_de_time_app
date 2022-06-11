import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_commons/app/domain/entities/goal_entity.dart';
import 'package:micro_commons/app/domain/entities/match_entity.dart';
import 'package:micro_commons/app/domain/entities/team_entity.dart';
import 'package:micro_core/core/errors/errors.dart';

import '../../domain/repositories/api_repository.dart';

import '../../domain/usecases/initialize_cup.dart';
import '../../domain/usecases/initialize_match.dart';
import '../../domain/usecases/register_goal.dart';
import '../../domain/usecases/update_match.dart';
import '../../domain/usecases/update_team.dart';
import '../datasources/api_datasource.dart';

class Api implements ApiRepository {
  final ApiDatasource apiDatasource;
  Api({
    required this.apiDatasource,
  });

  @override
  Future<Either<Failure, CupEntity>> initializeCup(CupParams params) async {
    try {
      return Right(await apiDatasource.initializeCup(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, MatchEntity>> initializeMatch(
      MatchParams params) async {
    try {
      return Right(await apiDatasource.initializeMatch(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, GoalEntity>> registerGoal(GoalParams params) async {
    try {
      return Right(await apiDatasource.registerGoal(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, CupEntity>> getCup(String params) async {
    try {
      return Right(await apiDatasource.getCup(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, MatchEntity>> updateMatch(
      UpdateMatchParams params) async {
    try {
      return Right(await apiDatasource.updateMatch(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, TeamEntity>> updateTeam(
      UpdateTeamParams params) async {
    try {
      return Right(await apiDatasource.updateTeam(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, void>> removeGoal(String params) async {
    try {
      return Right(await apiDatasource.removeGoal(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
