import 'dart:convert';

import 'package:dio/dio.dart';

import '../../core/di/di.dart';
import '../../core/helpers/cache_helper.dart';
import '../../domain/usecases/refresh_usecase.dart';
import '../models/payloads/refresh_payload.dart';

class CacheInterceptor extends InterceptorsWrapper {
  final CacheHelper _cacheHelper;

  CacheInterceptor(this._cacheHelper);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? token = await _cacheHelper.getToken();

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
      _cacheHelper.setToken(token);
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final dio = getIt<Dio>();

      final refreshToken = await _cacheHelper.getRefToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        return handler.next(err);
      }

      try {
        final result = await getIt<RefreshUseCase>().call(
          RefreshPayload(refreshToken: refreshToken),
        );

        return result.fold(
          (left) {
            handler.next(err);
          },
          (data) async {
            // update tokens
            final newAccessToken = data.accessToken;
            final newRefreshToken = data.refreshToken;

            _cacheHelper.setToken(newAccessToken);
            _cacheHelper.setRefToken(newRefreshToken);

            // retry original request
            final retryRequest = err.requestOptions;
            retryRequest.headers['Authorization'] = 'Bearer $newAccessToken';

            try {
              final retryResponse = await dio.fetch(retryRequest);
              handler.resolve(retryResponse);
            } catch (e) {
              handler.next(err);
            }
          },
        );
      } catch (e) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }
}
