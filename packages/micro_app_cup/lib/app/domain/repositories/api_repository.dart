import 'package:micro_commons/app/domain/entities/draw_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';

import '../usecases/draw_players_usecase.dart';

abstract class ApiRepository {
  Future<Either<Failure, DrawEntity>> drawPlayers(DrawParams params);
}
