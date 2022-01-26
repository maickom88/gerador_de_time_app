import 'package:micro_app_login/app/micro_app_login_resolver.dart';
import 'package:micro_app_nav/app/micro_app_nav_resolver.dart';
import 'package:micro_app_register/app/micro_app_regeister_resolver.dart';
import 'package:micro_app_welcome/micro_app_welcome.dart';
import 'package:micro_core/micro_core.dart';

class Resolvers {
  static List<MicroApp> apps = [
    MicroAppWelcomeResolver(),
    MicroAppLoginResolver(),
    MicroAppRegisterResolver(),
    MicroAppNavResolver(),
  ];
}
