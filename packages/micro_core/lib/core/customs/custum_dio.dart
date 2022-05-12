import 'package:dio/dio.dart';
import 'custum_interceptor.dart';

class CustumDio {
  late Dio _dio;
  Dio get http => _dio;

  CustumDio._run();
  static final CustumDio _singleton = CustumDio._run();
  factory CustumDio() => _singleton;

  Future<void> initialize(String baseUrl) async {
    _dio = Dio();
    _dio.interceptors.add(CustomInterceptors());
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 15000;
  }
}
