import 'package:micro_core/core/errors/errors.dart';

class ServerError implements Failure {
  @override
  String get message => 'An unexpected error has occurred';
}
