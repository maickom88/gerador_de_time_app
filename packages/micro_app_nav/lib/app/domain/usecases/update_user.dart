import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../entities/user_entity.dart';
import '../repositories/api_repository.dart';

class UpdateUser implements Usecase<UserEntity, UserEntity> {
  final ApiRepository apiRepository;
  UpdateUser({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, UserEntity>> call(UserEntity params) async {
    return await apiRepository.updateUser(params);
  }
}
