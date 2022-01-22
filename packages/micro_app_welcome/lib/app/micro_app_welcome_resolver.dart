import 'package:micro_core/micro_core.dart';

import 'pages/welcome/welcome_page.dart';
import 'factories/factories.dart';

class MicroAppWelcomeResolver implements MicroApp {
  @override
  String get appName => 'Welcome';

  @override
  Map<String, WidgetBuildArgs> get routes => {
        '/welcome': (_, args) =>
            WelcomePage(controller: builWelcomeController()),
      };
}
