import 'package:micro_commons/app/domain/entities/draw_entity.dart';
import 'package:micro_core/micro_core.dart';

import '../factories/build_cup_config_controller.dart';
import 'config/config_cup_page.dart';

class MicroAppConfigCupResolver implements MicroApp {
  @override
  String get appName => 'Configurations Cup';

  @override
  Map<String, WidgetBuildArgs> get routes => {
        '/config': (_, args) => ConfigCupPage(
              controller: buildCupConfigController((args as DrawEntity)),
            ),
      };
}
