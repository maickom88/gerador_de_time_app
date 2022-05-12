import 'package:micro_core/core/errors/errors.dart';

import 'server_error.dart';
import 'user_already_exist_error.dart';
import 'email_invalid_error.dart';
import 'incorrect_password_error.dart';
import 'login_cancel_error.dart';
import 'user_not_found_error.dart';

Failure firebaseHandlersErrors({typeError}) {
  if (typeError is LoginCancel) {
    return LoginCancel();
  }
  if (typeError?.code == "user-not-found") {
    return UserNotFound();
  }
  if (typeError?.message ==
      "The operation couldn’t be completed. (com.apple.AuthenticationServices.AuthorizationError error 1001.)") {
    return LoginCancel();
  }
  if (typeError?.code == "invalid-email") {
    return EmailInvalid();
  }
  if (typeError?.code == "wrong-password") {
    return IncorrectPassword();
  }
  if (typeError?.code == "email-already-in-use") {
    return UserAlreadyExist();
  }
  if (typeError?.code == "email-already-in-use") {
    return UserAlreadyExist();
  }

  return ServerError();
}
