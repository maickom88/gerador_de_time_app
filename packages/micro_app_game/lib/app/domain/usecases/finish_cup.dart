import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class FinishCup implements Usecase<String, CupEntity> {
  final ApiRepository apiRepository;
  FinishCup({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, CupEntity>> call(String params) async {
    return await apiRepository.finishCup(params);
  }
}
