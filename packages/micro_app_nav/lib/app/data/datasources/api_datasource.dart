import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_commons/app/domain/entities/notification_entity.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_commons/app/domain/entities/purchase_entity.dart';

import '../../domain/entities/cup_information_entity.dart';
import '../../domain/entities/position_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/sport_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/save_player_usecase.dart';

abstract class ApiDatasource {
  Future<List<SportEntity>> getSports();
  Future<void> deleteAccount(String params);
  Future<PurchaseEntity> getPurchase(String params);
  Future<List<NotificationEntity>> getNotifications(String params);
  Future<void> clearNotification(String params);
  Future<List<PositionEntity>> getPositions();
  Future<UserEntity> updateUser(UserEntity user);
  Future<List<CupEntity>> getCups(String params);
  Future<CupInformationEntity> getCupInformation(String params);
  Future<PlayerEntity> savePLayer(SavePlayerParams params);
  Future<void> removePlayers(List<String> params);
  Future<SkillEntity> saveSkill(SkillEntity params);
}
