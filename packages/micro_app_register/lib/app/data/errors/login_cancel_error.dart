import 'package:micro_core/core/errors/errors.dart';

class LoginCancel implements Failure {
  @override
  String get message => 'Login canceled by user';
}
