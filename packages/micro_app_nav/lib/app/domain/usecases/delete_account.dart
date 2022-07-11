import 'package:micro_core/core/errors/errors.dart';
import 'package:either_dart/either.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class DeleteAccount implements Usecase<String, void> {
  final ApiRepository apiRepository;
  DeleteAccount({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await apiRepository.deleteAccount(params);
  }
}
