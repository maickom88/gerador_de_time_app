import 'package:micro_commons/app/factories/build_resources.dart';

import '../pages/controllers/position_controller.dart';
import 'build_resources.dart';

PositionController buildPositionController() =>
    PositionController(getPositions, uploadFileUsecase);
