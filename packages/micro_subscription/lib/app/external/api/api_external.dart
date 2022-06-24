import 'package:micro_commons/app/domain/entities/purchase_entity.dart';
import 'package:micro_core/core/customs/custum_dio.dart';
import '../../data/errors/server_error.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/api_datasource.dart';
import '../../domain/usecases/register_purchase.dart';

class ApiExternal implements ApiDatasource {
  final CustumDio _dio;

  ApiExternal(
    this._dio,
  );

  @override
  Future<PurchaseEntity> registerPurchase(PurchaseParams params) async {
    try {
      final response = await _dio.http
          .post<Map<String, dynamic>>('/purchase', data: params.toMap());
      return PurchaseEntity.fromMap(response.data!);
    } on DioError catch (error) {
      throw error.error;
    } on Exception catch (_) {
      throw ServerError();
    }
  }
}
