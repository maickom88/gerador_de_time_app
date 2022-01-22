import 'package:either_dart/either.dart';
import '../errors/errors.dart';

abstract class Usecase<Input, Output> {
  Future<Either<Failure, Output>> call(Input input);
}

class NoParams {}
