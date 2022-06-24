import 'package:micro_core/core/customs/custum_dio.dart';
import 'package:micro_core/core/customs/custum_local_storage.dart';

import '../data/repositories/api.dart';
import '../domain/usecases/get_performace_usecase.dart';
import '../domain/usecases/get_players_usecase.dart';
import '../domain/usecases/update_device.dart';
import '../domain/usecases/upload_file.dart';
import '../external/api_external.dart';

final dio = CustumDio.instance;
final apiDatasource = ApiExternal(dio);
final apiRepository = Api(apiDatasource: apiDatasource);
final storage = CustumLocalStorage.instance.storage;
final getPlayersUsecase = GetPlayers(apiRepository: apiRepository);
final uploadFileUsecase = UploadFile(apiRepository: apiRepository);
final uploadDeviceUsecase = UpdateDevice(apiRepository: apiRepository);
final getPerformacePlayerUsecase =
    GetPerformacePlayer(apiRepository: apiRepository);
