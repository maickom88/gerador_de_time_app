import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';

import '../entities/sport_entity.dart';

abstract class ApiRepository {
  Future<Either<Failure, List<SportEntity>>> getSports();
}
