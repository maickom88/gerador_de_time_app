import '../pages/controllers/position_controller.dart';
import 'build_resources.dart';

PositionController buildPositionController() =>
    PositionController(getPositions);
