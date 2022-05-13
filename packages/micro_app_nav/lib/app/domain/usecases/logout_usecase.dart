import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/auth_repository.dart';

class Logout implements Usecase<NoParams, void> {
  final AuthRepository authRepository;
  Logout({
    required this.authRepository,
  });
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.logout();
  }
}
