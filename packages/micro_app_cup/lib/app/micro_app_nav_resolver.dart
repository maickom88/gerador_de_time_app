import 'package:micro_core/micro_core.dart';

import 'factories/build_cup_controller.dart';
import 'pages/cup/cup_page.dart';

class MicroAppCupResolver implements MicroApp {
  @override
  String get appName => 'Cup';

  @override
  Map<String, WidgetBuildArgs> get routes => {
        '/cup': (_, args) => CupPage(cupController: buildCupController()),
      };
}
