import 'package:micro_core/core/customs/custum_dio.dart';
import 'package:micro_core/core/customs/custum_local_storage.dart';

import '../data/repositories/api.dart';
import '../external/api_external.dart';
import '../usecases/get_players_usecase.dart';

final dio = CustumDio.instance;
final apiDatasource = ApiExternal(dio);
final apiRepository = Api(apiDatasource: apiDatasource);
final storage = CustumLocalStorage.instance.storage;
final getPlayersUsecase = GetPlayers(apiRepository: apiRepository);
