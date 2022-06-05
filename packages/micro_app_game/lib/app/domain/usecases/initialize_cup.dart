import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/cup_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class InitializeCup implements Usecase<CupParams, CupEntity> {
  final ApiRepository apiRepository;
  InitializeCup({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, CupEntity>> call(CupParams params) async {
    return await apiRepository.initializeCup(params);
  }
}

class CupParams {
  final String? guid;
  final String responsibleEmail;
  final String? guidSport;
  final List<String> guidTeams;
  final int time;
  final int? timeAdditions;
  final bool isDraft;
  CupParams({
    this.guid,
    required this.responsibleEmail,
    this.guidSport,
    required this.guidTeams,
    required this.time,
    this.timeAdditions,
    this.isDraft = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'guid': guid,
      'responsible_email': responsibleEmail,
      'guid_sport': guidSport,
      'guid_teams': guidTeams,
      'time': time,
      'time_additions': timeAdditions,
      'is_draft': isDraft,
    };
  }
}
