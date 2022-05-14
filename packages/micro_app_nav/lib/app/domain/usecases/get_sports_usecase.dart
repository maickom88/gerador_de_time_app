import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../entities/sport_entity.dart';
import '../repositories/api_repository.dart';

class GetSports implements Usecase<NoParams, List<SportEntity>> {
  final ApiRepository apiRepository;
  GetSports({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, List<SportEntity>>> call(NoParams params) async {
    return await apiRepository.getSports();
  }
}
