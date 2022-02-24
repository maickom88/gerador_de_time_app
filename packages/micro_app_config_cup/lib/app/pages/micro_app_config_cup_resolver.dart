import 'package:micro_core/micro_core.dart';

import 'config/config_cup_page.dart';

class MicroAppConfigCupResolver implements MicroApp {
  @override
  String get appName => 'Configurations Cup';

  @override
  Map<String, WidgetBuildArgs> get routes => {
        '/config': (_, args) => const ConfigCupPage(),
      };
}
