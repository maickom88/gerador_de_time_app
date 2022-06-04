import 'package:dio/dio.dart';

import '../errors/errors.dart';
import '../log/app_log.dart';
import 'custum_dio.dart';
import 'custum_firebase_auth.dart';

class CustomInterceptors extends Interceptor {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 404) {
      throw NotFound();
    }
    if (err.response?.statusCode == 500) {
      throw UnexpectedError();
    }
    if (err.response?.statusCode == 401) {
      final result = await CustumFirebaseAuth.getToken();
      if (result.isNotEmpty) {
        await CustumDio.instance.setToken(result);
        final opts = Options(
          method: err.requestOptions.method,
        );
        final cloneReq = await CustumDio.instance.http.request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        return handler.resolve(cloneReq);
      }
      throw Unauthorized();
    }
    if (err.response?.statusCode == 400) {
      throw UnexpectedError();
    }
    AppLog.writeLog(
        'Error in path: ${err.requestOptions.path}, menssage: ${err.message}');
    super.onError(err, handler);
  }
}
