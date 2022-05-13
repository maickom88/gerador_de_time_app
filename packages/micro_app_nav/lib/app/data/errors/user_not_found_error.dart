import 'package:micro_core/core/errors/errors.dart';

class UserNotFound implements Failure {
  @override
  String get message => 'User not found';
}
