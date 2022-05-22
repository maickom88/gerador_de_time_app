import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';

import '../../domain/entities/cup_information_entity.dart';
import '../../domain/entities/position_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/entities/sport_entity.dart';
import '../../domain/usecases/save_player_usecase.dart';

abstract class ApiDatasource {
  Future<List<SportEntity>> getSports();
  Future<List<PositionEntity>> getPositions();
  Future<List<CupEntity>> getCups(String params);
  Future<CupInformationEntity> getCupInformation(String params);
  Future<PlayerEntity> savePLayer(SavePlayerParams params);
  Future<void> removePlayers(List<String> params);
  Future<SkillEntity> saveSkill(SkillEntity params);
}
