import 'package:micro_core/micro_core.dart';

import 'factories/build_register_controller.dart';
import 'pages/subscription/subscription_page.dart';

class MicroAppSubscriptionResolver implements MicroApp {
  @override
  String get appName => 'subscritpion';

  @override
  Map<String, WidgetBuildArgs> get routes => {
        '/subscription': (_, args) =>
            SubscriptionPage(controller: buildSubscriptionController()),
      };
}
