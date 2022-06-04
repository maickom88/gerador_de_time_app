import 'package:micro_commons/app/domain/entities/draw_entity.dart';

import '../pages/controllers/cup_config_controller.dart';

CupConfigController buildCupConfigController(DrawEntity? draw) =>
    CupConfigController(draw: draw);
