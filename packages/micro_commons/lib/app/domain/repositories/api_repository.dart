import 'dart:io';

import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';

import '../entities/performace_entity.dart';
import '../entities/player_entity.dart';
import '../entities/skill_entity.dart';
import '../entities/user_entity.dart';
import '../usecases/update_device.dart';

abstract class ApiRepository {
  Future<Either<Failure, List<PlayerEntity>>> getPlayers(String params);
  Future<Either<Failure, UserEntity>> getInfoUser(String params);
  Future<Either<Failure, void>> removePlayers(List<String> params);
  Future<Either<Failure, void>> updateDevice(DeviceParams params);
  Future<Either<Failure, String>> uploadFile(File params);
  Future<Either<Failure, SkillEntity>> saveSkill(SkillEntity params);
  Future<Either<Failure, PerfomaceEntity>> getPerformacePlayer(String params);
}
