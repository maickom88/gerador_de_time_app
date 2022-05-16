import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';

import '../entities/player_entity.dart';
import '../entities/sport_entity.dart';

abstract class ApiRepository {
  Future<Either<Failure, List<SportEntity>>> getSports();
  Future<Either<Failure, List<PlayerEntity>>> getPlayers(String params);
}
