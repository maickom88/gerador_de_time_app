import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_commons/app/domain/entities/notification_entity.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_commons/app/domain/entities/purchase_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';

import '../entities/cup_information_entity.dart';
import '../entities/position_entity.dart';
import '../entities/skill_entity.dart';
import '../entities/sport_entity.dart';
import '../entities/user_entity.dart';
import '../usecases/save_player_usecase.dart';

abstract class ApiRepository {
  Future<Either<Failure, List<SportEntity>>> getSports();
  Future<Either<Failure, PurchaseEntity>> getPurchase(String params);
  Future<Either<Failure, void>> clearNotification(String params);
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
      String params);
  Future<Either<Failure, List<PositionEntity>>> getPositions();
  Future<Either<Failure, UserEntity>> updateUser(UserEntity params);
  Future<Either<Failure, List<CupEntity>>> getCups(String params);
  Future<Either<Failure, CupInformationEntity>> getCupInformation(
      String params);
  Future<Either<Failure, void>> removePlayers(List<String> params);
  Future<Either<Failure, SkillEntity>> saveSkill(SkillEntity params);
  Future<Either<Failure, PlayerEntity>> savePLayer(SavePlayerParams params);
}
