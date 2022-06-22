import 'package:micro_core/core/customs/custum_dio.dart';

import '../../data/datasources/api_datasource.dart';

class ApiExternal implements ApiDatasource {
  final CustumDio _dio;

  ApiExternal(
    this._dio,
  );
}
