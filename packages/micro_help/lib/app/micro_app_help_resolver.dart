import 'package:micro_core/micro_core.dart';
import 'pages/help/help_page.dart';

class MicroAppHelpResolver implements MicroApp {
  @override
  String get appName => 'Help';

  @override
  Map<String, WidgetBuildArgs> get routes => {
        '/help': (_, args) => const HelpPage(),
      };
}
