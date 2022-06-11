import '../domain/usecases/get_cup.dart';
import 'build_resources.dart';

final getCupUsecase = GetCup(apiRepository: apiRepository);
