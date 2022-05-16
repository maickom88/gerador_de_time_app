import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class RemovePlayers implements Usecase<List<String>, void> {
  final ApiRepository apiRepository;
  RemovePlayers({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, void>> call(List<String> params) async {
    return await apiRepository.removePlayers(params);
  }
}
