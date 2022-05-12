import 'package:micro_core/core/errors/errors.dart';

class IncorrectPassword implements Failure {
  @override
  String get message => 'Incorrect password';
}
