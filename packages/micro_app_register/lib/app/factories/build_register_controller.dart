import '../pages/register/register_controller.dart';
import 'build_resources.dart';

RegisterController buildRegisterController() =>
    RegisterController(registerAccountUsecase, notifyApiUsecase);
