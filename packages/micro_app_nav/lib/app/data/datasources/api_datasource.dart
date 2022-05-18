import 'package:micro_commons/app/entities/player_entity.dart';

import '../../domain/entities/position_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/sport_entity.dart';
import '../../domain/usecases/save_player_usecase.dart';

abstract class ApiDatasource {
  Future<List<SportEntity>> getSports();
  Future<List<PositionEntity>> getPositions();
  Future<PlayerEntity> savePLayer(SavePlayerParams params);
  Future<void> removePlayers(List<String> params);
  Future<SkillEntity> saveSkill(SkillEntity params);
}
