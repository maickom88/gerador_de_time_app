import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../entities/position_entity.dart';
import '../repositories/api_repository.dart';

class GetPositions implements Usecase<NoParams, List<PositionEntity>> {
  final ApiRepository apiRepository;
  GetPositions({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, List<PositionEntity>>> call(NoParams params) async {
    return await apiRepository.getPositions();
  }
}
