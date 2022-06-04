import 'package:micro_commons/app/factories/build_resources.dart';

import '../pages/controllers/cup_controller.dart';
import 'build_draw_players.dart';

CupController buildCupController() =>
    CupController(getPlayersUsecase, drawPLayersUsecase, storage);
