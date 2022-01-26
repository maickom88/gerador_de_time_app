import 'package:micro_core/micro_core.dart';

import 'factories/build_nav_controller.dart';
import 'pages/nav/nav_page.dart';

class MicroAppNavResolver implements MicroApp {
  @override
  String get appName => 'Login';

  @override
  Map<String, WidgetBuildArgs> get routes => {
        '/nav': (_, args) => NavPage(controller: buildNavController()),
      };
}
