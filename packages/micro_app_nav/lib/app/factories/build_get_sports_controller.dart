import '../pages/controllers/home_controller.dart';
import 'build_resources.dart';

HomeController buildHomeController() => HomeController(
      getSportsUsecase,
      storage,
    );
