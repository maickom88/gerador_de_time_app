import 'dart:io';

import '../../domain/entities/performace_entity.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/update_device.dart';

abstract class ApiDatasource {
  Future<List<PlayerEntity>> getPlayers(String params);
  Future<PerfomaceEntity> getPerformacePlayer(String params);
  Future<void> removePlayers(List<String> params);
  Future<void> updateDevice(DeviceParams params);
  Future<SkillEntity> saveSkill(SkillEntity params);
  Future<UserEntity> getInfoUser(String params);
  Future<String> uploadFile(File params);
}
