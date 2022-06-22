import 'package:micro_app_config_cup/app/pages/micro_app_config_cup_resolver.dart';
import 'package:micro_app_cup/app/micro_app_nav_resolver.dart';
import 'package:micro_app_game/app/pages/micro_app_resume_game_resolver.dart';
import 'package:micro_app_login/app/micro_app_login_resolver.dart';
import 'package:micro_app_nav/app/micro_app_nav_resolver.dart';
import 'package:micro_app_register/app/micro_app_regeister_resolver.dart';
import 'package:micro_app_welcome/micro_app_welcome.dart';
import 'package:micro_core/micro_core.dart';
import 'package:micro_subscription/app/micro_app_subscription_resolver.dart';

class Resolvers {
  static List<MicroApp> apps = [
    MicroAppWelcomeResolver(),
    MicroAppLoginResolver(),
    MicroAppRegisterResolver(),
    MicroAppNavResolver(),
    MicroAppCupResolver(),
    MicroAppConfigCupResolver(),
    MicroAppResumeGameResolver(),
    MicroAppSubscriptionResolver(),
  ];
}
