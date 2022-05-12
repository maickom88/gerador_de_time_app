import 'package:micro_core/micro_core.dart';

import 'factories/build_login_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/login/login_page.dart';

class MicroAppLoginResolver implements MicroApp {
  @override
  String get appName => 'Login';

  @override
  Map<String, WidgetBuildArgs> get routes => {
        '/login': (_, args) => LoginPage(controller: buildLoginController()),
      };

  Future<MicroAppLoginResolver> onExecute() async {
    await Firebase.initializeApp();
    return this;
  }
}
