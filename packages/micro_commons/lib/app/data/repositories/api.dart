import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';

import '../../domain/entities/performace_entity.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/repositories/api_repository.dart';
import '../datasources/api_datasource.dart';

class Api implements ApiRepository {
  final ApiDatasource apiDatasource;
  Api({
    required this.apiDatasource,
  });

  @override
  Future<Either<Failure, List<PlayerEntity>>> getPlayers(String params) async {
    try {
      return Right(await apiDatasource.getPlayers(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, SkillEntity>> saveSkill(SkillEntity params) async {
    try {
      return Right(await apiDatasource.saveSkill(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, void>> removePlayers(List<String> params) async {
    try {
      return Right(await apiDatasource.removePlayers(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, PerfomaceEntity>> getPerformacePlayer(
      String params) async {
    try {
      return Right(await apiDatasource.getPerformacePlayer(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
