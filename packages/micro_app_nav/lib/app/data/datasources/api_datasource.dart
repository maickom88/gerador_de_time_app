import '../../domain/entities/player_entity.dart';
import '../../domain/entities/position_entity.dart';
import '../../domain/entities/sport_entity.dart';

abstract class ApiDatasource {
  Future<List<SportEntity>> getSports();
  Future<List<PositionEntity>> getPositions();
  Future<List<PlayerEntity>> getPlayers(String params);
}
