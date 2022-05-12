import 'package:micro_core/core/errors/errors.dart';

class EmailInvalid implements Failure {
  @override
  String get message => 'This email is invalid';
}
