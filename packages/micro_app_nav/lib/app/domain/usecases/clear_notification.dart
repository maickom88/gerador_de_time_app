import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';
import 'package:either_dart/either.dart';

import '../repositories/api_repository.dart';

class ClearNotification implements Usecase<String, void> {
  final ApiRepository apiRepository;
  ClearNotification({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await apiRepository.clearNotification(params);
  }
}
