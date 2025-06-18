import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../core/helpers/parse_helper.dart';
import '../../core/helpers/log_helper.dart';
import '../models/api/api_error.dart';
import '../models/api/api_response.dart';

class ApiHandler {
  final LogHelper logger;
  final void Function(ApiError error)? onError;

  ApiHandler(this.logger, {this.onError});

  Future<ApiResponse<T>> execute<T>(
    Future<Response<String>> Function() apiCall,
    T Function(Object? json) fromJsonT,
  ) async {
    try {
      final response = await apiCall();
      final statusCode = response.statusCode ?? 0;
      final rawData = response.data ?? "";

      /// Handle 204 or empty response
      if (statusCode == 204 || rawData.trim().isEmpty) {
        logger.d("Empty successful response for status $statusCode");
        return ApiResponse<T>.success(null as T);
      }

      final decoded = jsonDecode(rawData) as Map<String, dynamic>;

      if ([200, 201].contains(statusCode)) {
        return ApiResponse<T>.fromJson(decoded, fromJsonT);
      } else {
        return ApiResponse.failure(
          ApiError.fromJson(decoded["error"] ?? decoded),
        );
      }
    } on DioException catch (dioError) {
      return _handleDioError<T>(dioError);
    } on Exception catch (e) {
      return _handleException(e);
    } catch (e) {
      logger.e("execute error: $e");
      return ApiResponse.failure(ApiError.unknownError());
    }
  }

  ApiResponse<T> _handleDioError<T>(DioException dioError) {
    try {
      final Response? response = dioError.response;
      final int statusCode = response?.statusCode ?? 500;
      dynamic data = response?.data;

      if (data is String) {
        data = jsonDecode(data);
      }

      if (data is Map<String, dynamic>) {
        return parseApiError<T>(statusCode, data, onError: onError);
      } else {
        if (dioError.type == DioExceptionType.connectionTimeout ||
            dioError.type == DioExceptionType.sendTimeout ||
            dioError.type == DioExceptionType.receiveTimeout) {
          return ApiResponse.failure(
            ApiError.build(
              statusCode: 408,
              message: "Request timed out. Please try again.",
            ),
          );
        } else if (dioError.type == DioExceptionType.badResponse) {
          final error = ApiError.build(
            statusCode: statusCode,
            message: "Bad response from server.",
          );
          onError?.call(error);
          return ApiResponse.failure(error);
        } else if (dioError.type == DioExceptionType.cancel) {
          return ApiResponse.failure(
            ApiError.build(statusCode: 499, message: "Request was cancelled."),
          );
        } else if (dioError.type == DioExceptionType.connectionError) {
          return ApiResponse.failure(
            ApiError.build(
              statusCode: 503,
              message: "No internet connection. Please check your network.",
            ),
          );
        } else if (dioError.type == DioExceptionType.unknown) {
          return ApiResponse.failure(ApiError.unknownError());
        } else {
          return ApiResponse.failure(ApiError.unknownError());
        }
      }
    } on Exception catch (e) {
      return _handleException(e);
    } catch (e) {
      logger.e("_handleDioError error: $e");
      return ApiResponse.failure(ApiError.unknownError());
    }
  }

  ApiResponse<T> _handleException<T>(Exception exception) {
    final error =
        (exception is TimeoutException)
            ? ApiError.build(
              statusCode: 408,
              message: "Request timed out. Please try again.",
            )
            : ApiError.unknownError();

    onError?.call(error);
    return ApiResponse.failure(error);
  }
}
