import 'position_controller.dart';

class CustumPositionController {
  late PositionController positionController;

  PositionController get controller => positionController;

  CustumPositionController._run();
  static final CustumPositionController _singleton =
      CustumPositionController._run();
  static CustumPositionController get instance => _singleton;
  factory CustumPositionController() => _singleton;

  CustumPositionController initialize(PositionController controller) {
    positionController = controller;
    return _singleton;
  }
}
