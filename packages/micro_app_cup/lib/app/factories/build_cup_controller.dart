import 'package:micro_commons/app/factories/build_resources.dart';

import '../pages/controllers/cup_controller.dart';

CupController buildCupController() => CupController(getPlayersUsecase, storage);
