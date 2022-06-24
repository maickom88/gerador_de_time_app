import 'package:micro_commons/app/factories/build_resources.dart';

import '../pages/controllers/logout_controller.dart';
import 'build_resources.dart';

LogoutController buildLoginController() =>
    LogoutController(logoutUsecase, updateUser, uploadFileUsecase, storage);
