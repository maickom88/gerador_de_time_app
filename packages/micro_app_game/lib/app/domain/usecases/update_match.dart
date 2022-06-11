import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/match_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class UpdateMatch implements Usecase<UpdateMatchParams, MatchEntity> {
  final ApiRepository apiRepository;
  UpdateMatch({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, MatchEntity>> call(UpdateMatchParams params) async {
    return await apiRepository.updateMatch(params);
  }
}

class UpdateMatchParams {
  final String guid;
  final int totalTimePause;
  final int finalTime;
  final int totalGoals;
  UpdateMatchParams({
    required this.guid,
    required this.totalTimePause,
    required this.finalTime,
    required this.totalGoals,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'total_time_pause': totalTimePause,
      'final_time': finalTime,
      'total_goals': totalGoals,
    };
  }
}
