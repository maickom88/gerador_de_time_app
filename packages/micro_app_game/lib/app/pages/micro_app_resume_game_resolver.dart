import 'package:micro_commons/app/domain/entities/config_team_entity.dart';
import 'package:micro_core/micro_core.dart';

import '../factories/build_cup_controller.dart';
import 'resume_game/resume_game_page.dart';

class MicroAppResumeGameResolver implements MicroApp {
  @override
  String get appName => 'Resume Game';

  @override
  Map<String, WidgetBuildArgs> get routes => {
        '/resume-game': (_, args) => ResumeGamePage(
              controller: buildResumeController(args as ConfigTeamEntity)
                ..initializeCup(),
            ),
      };
}
