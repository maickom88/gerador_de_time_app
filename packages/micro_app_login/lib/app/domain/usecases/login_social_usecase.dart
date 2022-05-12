import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../../../core/enums/type_provider_enum.dart';
import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';

class LoginWithSocial implements Usecase<TypeProviderSocial, AuthResponse> {
  final AuthRepository authRepository;
  LoginWithSocial({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, AuthResponse>> call(TypeProviderSocial params) async {
    return await authRepository.loginWithSocial(params);
  }
}
