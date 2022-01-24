import 'pages/register/register_page.dart';
import 'package:micro_core/micro_core.dart';

import 'factories/build_register_controller.dart';

class MicroAppRegisterResolver implements MicroApp {
  @override
  String get appName => 'Register';

  @override
  Map<String, WidgetBuildArgs> get routes => {
        '/register': (_, args) =>
            RegisterPage(controller: buildRegisterController()),
      };
}
