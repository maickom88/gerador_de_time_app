import 'package:micro_core/micro_core.dart';

import 'factories/build_get_notifications.dart';
import 'factories/build_get_positions_controller.dart';
import 'factories/build_get_sports_controller.dart';
import 'factories/build_historic_controller.dart';
import 'factories/build_logout_controller.dart';
import 'factories/build_nav_controller.dart';
import 'factories/build_team_controller.dart';
import 'pages/controllers/custum_position_controller.dart';
import 'pages/nav/nav_page.dart';

class MicroAppNavResolver implements MicroApp {
  @override
  String get appName => 'Nav';

  @override
  Map<String, WidgetBuildArgs> get routes => {
        '/nav': (_, args) => NavPage(
              controller: buildNavController(),
              logoutController: buildLoginController()..initialize(),
              homeController: buildHomeController()..getSports(_),
              teamController: buildTeamController()..getPlayers(),
              positionController: CustumPositionController.instance
                  .initialize(buildPositionController())
                  .controller
                ..getPositions(),
              historicController: buildHistoricController()..getHistorics(),
              notificationController: buildNotificationController()
                ..getNotifications(),
            ),
      };
}
