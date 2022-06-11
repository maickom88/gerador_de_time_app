import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/match_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class InitializeMatch implements Usecase<MatchParams, MatchEntity> {
  final ApiRepository apiRepository;
  InitializeMatch({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, MatchEntity>> call(MatchParams params) async {
    return await apiRepository.initializeMatch(params);
  }
}

class MatchParams {
  final String? guid;
  final String guidHomeTeam;
  final String guidOpposingTeam;
  final int time;
  final int? timeAdditions;
  final String guidCup;
  MatchParams({
    this.guid,
    required this.guidHomeTeam,
    required this.guidOpposingTeam,
    required this.time,
    this.timeAdditions,
    required this.guidCup,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'guid_home_team': guidHomeTeam,
      'guid_opposing_team': guidOpposingTeam,
      'time': time,
      'time_additions': timeAdditions,
      'guid_cup': guidCup,
    };
  }
}
