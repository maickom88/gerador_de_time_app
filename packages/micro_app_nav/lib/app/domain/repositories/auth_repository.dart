import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> logout();
}
