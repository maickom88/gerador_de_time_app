import 'package:micro_commons/app/domain/entities/draw_entity.dart';

import '../pages/controllers/cup_config_controller.dart';
import 'build_register_team.dart';

CupConfigController buildCupConfigController(DrawEntity? draw) =>
    CupConfigController(registerTeamUsecase, draw: draw);
