import 'package:micro_commons/app/domain/entities/config_team_entity.dart';

import '../pages/controllers/resume_game_controller.dart';
import 'build_initialize_cup.dart';

ResumeController buildResumeController(ConfigTeamEntity configCup) =>
    ResumeController(initializeCupUsecase, configCup: configCup);
