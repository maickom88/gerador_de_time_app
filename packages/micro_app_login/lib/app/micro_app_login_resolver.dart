import 'package:micro_core/micro_core.dart';

import 'factories/build_login_controller.dart';
import 'pages/login/login_page.dart';

class MicroAppLoginResolver implements MicroApp {
  @override
  String get appName => 'Login';

  @override
  Map<String, WidgetBuildArgs> get routes => {
        '/login': (_, args) => LoginPage(controller: buildLoginController()),
      };
}
