import '../pages/controllers/team_controller.dart';
import 'build_resources.dart';

TeamController buildTeamController() =>
    TeamController(getPlayersUsecase, storage);
