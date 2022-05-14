import 'package:dio/dio.dart';
import 'custum_interceptor.dart';

class CustumDio {
  late Dio _dio;
  Dio get http => _dio;

  CustumDio._run();
  static final CustumDio _singleton = CustumDio._run();
  static CustumDio get instance => _singleton;

  factory CustumDio() => _singleton;

  Future<void> initialize(String baseUrl, {String? token}) async {
    _dio = Dio();
    _dio.interceptors.add(CustomInterceptors());
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers['x-api-key'] = token;
  }
}
