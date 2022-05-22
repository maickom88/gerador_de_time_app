import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../entities/cup_information_entity.dart';
import '../repositories/api_repository.dart';

class GetCupInformation implements Usecase<String, CupInformationEntity> {
  final ApiRepository apiRepository;
  GetCupInformation({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, CupInformationEntity>> call(String params) async {
    return await apiRepository.getCupInformation(params);
  }
}
