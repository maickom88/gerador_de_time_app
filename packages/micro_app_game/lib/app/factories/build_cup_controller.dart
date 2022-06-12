import 'package:micro_commons/app/domain/entities/config_team_entity.dart';

import '../pages/controllers/resume_game_controller.dart';
import 'build_finish_cup.dart';
import 'build_get_cup.dart';
import 'build_initialize_cup.dart';
import 'build_initialize_match.dart';
import 'build_register_goal.dart';
import 'build_remove_goal.dart';
import 'build_update_match.dart';
import 'build_update_team.dart';

ResumeController buildResumeController(ConfigTeamEntity configCup) =>
    ResumeController(
      initializeMatchUsecase,
      removeGoalUsecase,
      getCupUsecase,
      finishCupUsecase,
      updateTeamUsecase,
      updateMatchUsecase,
      registerGoalUsecase,
      initializeCupUsecase,
      configCup: configCup,
    );
