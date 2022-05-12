import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';

import '../../domain/entities/auth_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';

class Auth implements AuthRepository {
  final AuthDatasource authDatasource;
  Auth({
    required this.authDatasource,
  });
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return Right(await authDatasource.logout());
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> registerAccount(
      String email, String password) async {
    try {
      return Right(await authDatasource.registerAccount(email, password));
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification(
      String email, String password) async {
    try {
      return Right(await authDatasource.sendEmailVerification(email, password));
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
