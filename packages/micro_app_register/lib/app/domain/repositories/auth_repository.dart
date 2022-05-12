import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';

import '../entities/auth_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> registerAccount(
      String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> sendEmailVerification(
      String email, String password);
}
