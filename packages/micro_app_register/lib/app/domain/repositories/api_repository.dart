import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';

import '../entities/user_entity.dart';

abstract class ApiRepository {
  Future<Either<Failure, UserEntity>> notifyApi(String? params);
}
