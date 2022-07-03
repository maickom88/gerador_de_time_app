import 'package:dio/dio.dart';

import '../errors/errors.dart';
import '../log/app_log.dart';
import 'custum_dio.dart';
import 'custum_firebase_auth.dart';

class CustomInterceptors extends Interceptor {
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 404) {
      err.error = NotFound();
    }
    if (err.response?.statusCode == 500) {
      err.error = UnexpectedError();
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
      err.error = Unauthorized();
    }
    if (err.response?.statusCode == 400) {
      err.error = UnexpectedError();
    }
    if (err.message == "DioErrorType.connectTimeout" ||
        err.message == "Connecting timed out [60000ms]") {
      err.error = ConnectTimeoutError();
    }
    AppLog.writeLog(
        'Error in path: ${err.requestOptions.path}, menssage: ${err.message}');
    super.onError(err, handler);
  }
}
