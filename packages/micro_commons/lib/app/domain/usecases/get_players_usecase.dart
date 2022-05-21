import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../entities/player_entity.dart';
import '../repositories/api_repository.dart';

class GetPlayers implements Usecase<String, List<PlayerEntity>> {
  final ApiRepository apiRepository;
  GetPlayers({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, List<PlayerEntity>>> call(String params) async {
    return await apiRepository.getPlayers(params);
  }
}
