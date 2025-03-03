import 'package:dio/dio.dart';
import 'package:misyonbank/configs/service/api_endpoints.dart';

class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
    ),
  );

  Dio get dio => _dio;
}
