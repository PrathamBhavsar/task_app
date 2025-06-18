import '../../data/models/api/api_error.dart';
import '../../data/models/api/api_response.dart';
import '../di/di.dart';
import 'snack_bar_helper.dart';

ApiResponse<T> parseApiError<T>(
    int statusCode,
    Map<String, dynamic> json, {
      void Function(ApiError error)? onError,
    }) {
  final error = json["error"] ?? json;
  final message = error["message"] ?? 'Unknown error';
  final apiError = ApiError.build(statusCode: statusCode, message: message);
  onError?.call(apiError);

  return ApiResponse.failure(apiError);
}

