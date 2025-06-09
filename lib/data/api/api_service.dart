import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Response<String>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  Future<Response<String>> post(String path, {dynamic data}) async {
    return _dio.post(path, data: data);
  }

  Future<Response<String>> patch(String path, {dynamic data}) async {
    return _dio.patch(path, data: data);
  }

  Future<Response<String>> delete(String path, {dynamic data}) async {
    return _dio.delete(path, data: data);
  }
}
