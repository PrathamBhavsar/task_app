import 'dart:convert';

import 'package:dio/dio.dart';

import '../../core/di/di.dart';
import '../../core/helpers/cache_helper.dart';

class CacheInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final String? token = await getIt<CacheHelper>().getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      print(token);
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = jsonDecode(response.data);
    final String? token = data["token"];

    if (token != null && token.isNotEmpty) {
      getIt<CacheHelper>().setToken(token);
    }

    handler.next(response);
  }
}
