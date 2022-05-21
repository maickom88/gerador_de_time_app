import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';

import '../entities/position_entity.dart';
import '../entities/skill_entity.dart';
import '../entities/sport_entity.dart';
import '../usecases/save_player_usecase.dart';

abstract class ApiRepository {
  Future<Either<Failure, List<SportEntity>>> getSports();
  Future<Either<Failure, List<PositionEntity>>> getPositions();
  Future<Either<Failure, void>> removePlayers(List<String> params);
  Future<Either<Failure, SkillEntity>> saveSkill(SkillEntity params);
  Future<Either<Failure, PlayerEntity>> savePLayer(SavePlayerParams params);
}
