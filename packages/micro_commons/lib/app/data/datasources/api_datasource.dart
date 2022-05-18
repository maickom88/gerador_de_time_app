import '../../entities/player_entity.dart';
import '../../entities/skill_entity.dart';

abstract class ApiDatasource {
  Future<List<PlayerEntity>> getPlayers(String params);
  // Future<PlayerEntity> savePLayer(SavePlayerParams params);
  Future<void> removePlayers(List<String> params);
  Future<SkillEntity> saveSkill(SkillEntity params);
}
