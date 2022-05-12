import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';
import 'package:either_dart/either.dart';

import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';

class LoginWithEmailAndPassword implements Usecase<LoginParams, AuthResponse> {
  final AuthRepository authRepository;
  LoginWithEmailAndPassword({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, AuthResponse>> call(LoginParams params) async {
    return await authRepository.loginWithEmailAndPassword(
        params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;
  LoginParams({
    required this.email,
    required this.password,
  });
}
