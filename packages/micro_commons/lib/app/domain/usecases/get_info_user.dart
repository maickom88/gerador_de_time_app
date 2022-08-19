import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../entities/user_entity.dart';
import '../repositories/api_repository.dart';

class GetInfoUser implements Usecase<String, UserEntity> {
  final ApiRepository apiRepository;
  GetInfoUser({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, UserEntity>> call(String params) async {
    return await apiRepository.getInfoUser(params);
  }
}
