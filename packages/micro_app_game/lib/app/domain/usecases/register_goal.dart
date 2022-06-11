import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/goal_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class RegisterGoal implements Usecase<GoalParams, GoalEntity> {
  final ApiRepository apiRepository;
  RegisterGoal({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, GoalEntity>> call(GoalParams params) async {
    return await apiRepository.registerGoal(params);
  }
}

class GoalParams {
  final String? guid;
  final String timeGoals;
  final String guidPlayer;
  final String guidMacth;
  GoalParams({
    this.guid,
    required this.timeGoals,
    required this.guidPlayer,
    required this.guidMacth,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'time_goals': timeGoals,
      'guid_player': guidPlayer,
      'guid_macth': guidMacth,
    };
  }
}
