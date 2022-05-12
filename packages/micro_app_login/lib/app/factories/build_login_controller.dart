import '../pages/login/login_controller.dart';
import 'build_resources.dart';

LoginController buildLoginController() => LoginController(
      loginSocialUsecase,
      loginWithEmailAndPasswordUsecase,
    );
