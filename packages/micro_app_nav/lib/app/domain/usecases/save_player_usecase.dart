import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:micro_commons/app/entities/player_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class SavePlayer implements Usecase<SavePlayerParams, PlayerEntity> {
  final ApiRepository apiRepository;
  SavePlayer({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, PlayerEntity>> call(SavePlayerParams params) async {
    return await apiRepository.savePLayer(params);
  }
}

class SavePlayerParams {
  final String? photo;
  final String userGuid;
  final String? guidSkill;
  final String guidPosition;
  final String name;
  SavePlayerParams({
    this.photo,
    required this.userGuid,
    this.guidSkill,
    required this.guidPosition,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'photo': photo,
      'user_guid': userGuid,
      'guid_skill': guidSkill,
      'guid_position': guidPosition,
      'name': name,
    };
  }

  String toJson() => json.encode(toMap());
}
