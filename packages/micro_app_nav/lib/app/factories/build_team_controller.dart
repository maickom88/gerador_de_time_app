import 'package:micro_commons/app/factories/build_resources.dart';

import '../pages/controllers/team_controller.dart';
import 'build_resources.dart';

TeamController buildTeamController() => TeamController(
      getPlayersUsecase,
      savePLayer,
      removerPLayers,
      saveSkill,
      storage,
    );
