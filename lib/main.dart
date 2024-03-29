import 'package:flutter/material.dart';
import 'package:micro_core/core/base_app.dart';
import 'package:micro_core/core/core_app.dart';
import 'package:micro_core/core/guard/zone_guard.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:micro_core/utils/core_utils.dart';

import 'resolvers/resolvers.dart';
import 'routes/routes.dart';

Future<void> main() async {
  ZoneGuard.withObservableError(() async {
    await BaseRoutes.initialize();
    runApp(
      GeradorDeTimes()..registerRoutes(),
    );
  });
}

class GeradorDeTimes extends StatelessWidget with BaseApp {
  GeradorDeTimes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gerador de Times',
      theme: ThemeApp.theme(),
      navigatorKey: navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: BaseRoutes.initialRoute,
    );
  }

  @override
  Map<String, WidgetBuildArgs> get baseRoutes => {};

  @override
  Route? generateRoute(RouteSettings settings) {
    final routerName = settings.name;
    final routerArgs = settings.arguments;

    final navigateTo = routes[routerName];
    if (navigateTo == null) return null;

    return MaterialPageRoute(
      builder: (context) => navigateTo.call(context, routerArgs),
    );
  }

  @override
  List<MicroApp> get microApps => Resolvers.apps;

  @override
  void registerRoutes() {
    if (baseRoutes.isNotEmpty) routes.addAll(baseRoutes);
    if (microApps.isNotEmpty) {
      for (MicroApp microApp in microApps) {
        routes.addAll(microApp.routes);
      }
    }
  }
}
