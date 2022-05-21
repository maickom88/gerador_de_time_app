import 'package:micro_commons/app/factories/build_resources.dart';

import '../pages/controllers/historic_controller.dart';
import 'build_resources.dart';

HistoricController buildHistoricController() => HistoricController(
      getCupsUsecase,
      storage,
    );
