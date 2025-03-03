import 'package:dio/dio.dart';
import 'dio_client.dart';

class ApiService {
  final DioClient _dioClient;

  ApiService(this._dioClient);

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    return await _dioClient.dio.get(endpoint, queryParameters: params);
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    return await _dioClient.dio.post(endpoint, data: data);
  }
}
