import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:micro_commons/app/domain/entities/draw_entity.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_core/core/errors/errors.dart';
import 'package:micro_core/core/usecases/usecases.dart';

import '../repositories/api_repository.dart';

class DrawPlayers implements Usecase<DrawParams, DrawEntity> {
  final ApiRepository apiRepository;
  DrawPlayers({
    required this.apiRepository,
  });
  @override
  Future<Either<Failure, DrawEntity>> call(DrawParams params) async {
    return await apiRepository.drawPlayers(params);
  }
}

class DrawParams {
  final bool balanceTeams;
  final int numberOfTeams;
  final List<PlayerEntity> players;
  DrawParams({
    required this.balanceTeams,
    required this.numberOfTeams,
    required this.players,
  });

  Map<String, dynamic> toMap() {
    return {
      'balance_teams': balanceTeams,
      'number_of_teams': numberOfTeams,
      'players': players.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
