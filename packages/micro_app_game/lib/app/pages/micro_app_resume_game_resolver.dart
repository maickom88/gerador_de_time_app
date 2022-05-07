import 'package:micro_core/micro_core.dart';

import 'resume_game/resume_game_page.dart';

class MicroAppResumeGameResolver implements MicroApp {
  @override
  String get appName => 'Resume Game';

  @override
  Map<String, WidgetBuildArgs> get routes => {
        '/resume-game': (_, args) => const ResumeGamePage(),
      };
}
