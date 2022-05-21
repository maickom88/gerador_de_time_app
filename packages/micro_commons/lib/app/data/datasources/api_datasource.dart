import '../../domain/entities/performace_entity.dart';
import '../../domain/entities/player_entity.dart';
import '../../domain/entities/skill_entity.dart';

abstract class ApiDatasource {
  Future<List<PlayerEntity>> getPlayers(String params);
  Future<PerfomaceEntity> getPerformacePlayer(String params);
  Future<void> removePlayers(List<String> params);
  Future<SkillEntity> saveSkill(SkillEntity params);
}
