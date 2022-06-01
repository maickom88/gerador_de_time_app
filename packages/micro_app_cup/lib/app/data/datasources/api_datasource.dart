import 'package:micro_commons/app/domain/entities/draw_entity.dart';

import '../../domain/usecases/draw_players_usecase.dart';

abstract class ApiDatasource {
  Future<DrawEntity> drawPlayers(DrawParams params);
}
