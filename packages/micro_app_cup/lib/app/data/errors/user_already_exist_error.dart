import 'package:micro_core/core/errors/errors.dart';

class UserAlreadyExist implements Failure {
  @override
  String get message => 'User already exist';
}
