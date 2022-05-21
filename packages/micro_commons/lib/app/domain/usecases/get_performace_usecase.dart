import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../entities/performace_entity.dart';
import '../repositories/api_repository.dart';

class GetPerformacePlayer implements Usecase<String, PerfomaceEntity> {
  final ApiRepository apiRepository;
  GetPerformacePlayer({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, PerfomaceEntity>> call(String params) async {
    return await apiRepository.getPerformacePlayer(params);
  }
}
