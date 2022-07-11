import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_commons/app/domain/entities/notification_entity.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_commons/app/domain/entities/purchase_entity.dart';
import 'package:micro_core/core/errors/errors.dart';

import '../../domain/entities/cup_information_entity.dart';
import '../../domain/entities/position_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/sport_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/api_repository.dart';
import '../../domain/usecases/save_player_usecase.dart';
import '../datasources/api_datasource.dart';

class Api implements ApiRepository {
  final ApiDatasource apiDatasource;
  Api({
    required this.apiDatasource,
  });
  @override
  Future<Either<Failure, List<SportEntity>>> getSports() async {
    try {
      return Right(await apiDatasource.getSports());
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, List<PositionEntity>>> getPositions() async {
    try {
      return Right(await apiDatasource.getPositions());
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, PlayerEntity>> savePLayer(
      SavePlayerParams params) async {
    try {
      return Right(await apiDatasource.savePLayer(params));
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
  Future<Either<Failure, List<CupEntity>>> getCups(String params) async {
    try {
      return Right(await apiDatasource.getCups(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, CupInformationEntity>> getCupInformation(
      String params) async {
    try {
      return Right(await apiDatasource.getCupInformation(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
      String params) async {
    try {
      return Right(await apiDatasource.getNotifications(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(UserEntity params) async {
    try {
      return Right(await apiDatasource.updateUser(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, void>> clearNotification(String params) async {
    try {
      return Right(await apiDatasource.clearNotification(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, PurchaseEntity>> getPurchase(String params) async {
    try {
      return Right(await apiDatasource.getPurchase(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(String params) async {
    try {
      return Right(await apiDatasource.deleteAccount(params));
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
