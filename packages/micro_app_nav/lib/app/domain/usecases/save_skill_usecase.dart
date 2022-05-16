import 'package:either_dart/either.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../entities/skill_entity.dart';
import '../repositories/api_repository.dart';

class SaveSkill implements Usecase<SkillEntity, SkillEntity> {
  final ApiRepository apiRepository;
  SaveSkill({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, SkillEntity>> call(SkillEntity params) async {
    return await apiRepository.saveSkill(params);
  }
}
