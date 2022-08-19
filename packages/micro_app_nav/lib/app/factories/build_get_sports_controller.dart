import 'package:micro_commons/app/factories/build_resources.dart';

import '../pages/controllers/home_controller.dart';
import 'build_resources.dart';

HomeController buildHomeController() => HomeController(
      getSportsUsecase,
      uploadDeviceUsecase,
      getInfoUserUsecase,
      logoutUsecase,
      storage,
    );
