import 'package:micro_core/core/customs/custum_dio.dart';

import '../data/repositories/api.dart';
import '../domain/usecases/register_purchase.dart';
import '../external/api/api_external.dart';

final dio = CustumDio.instance;
final apiDatasource = ApiExternal(dio);
final apiRepository = Api(apiDatasource: apiDatasource);
final registerPurchaseUsecase = RegisterPurchase(apiRepository: apiRepository);
