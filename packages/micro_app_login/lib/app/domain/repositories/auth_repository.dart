import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';

import '../../../core/enums/type_provider_enum.dart';
import '../entities/auth_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> loginWithSocial(
      TypeProviderSocial params);
  Future<Either<Failure, AuthResponse>> loginWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> sendEmailVerification(
      String email, String password);
}
