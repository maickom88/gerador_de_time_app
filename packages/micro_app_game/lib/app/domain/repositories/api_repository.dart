import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';

import '../usecases/initialize_cup.dart';

abstract class ApiRepository {
  Future<Either<Failure, CupEntity>> initializeCup(CupParams params);
}
