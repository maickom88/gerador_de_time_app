import 'package:dio/dio.dart';

import '../errors/errors.dart';
import '../log/app_log.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 404) {
      throw NotFound();
    }
    if (err.response?.statusCode == 500) {
      throw UnexpectedError();
    }
    if (err.response?.statusCode == 401) {
      throw Unauthorized();
    }
    AppLog.writeLog(
        'Error in path: ${err.requestOptions.path}, menssage: ${err.message}');
    super.onError(err, handler);
  }
}
