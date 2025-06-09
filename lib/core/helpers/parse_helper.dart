import '../../data/models/api/api_error.dart';
import '../../data/models/api/api_response.dart';

ApiResponse<T> parseApiError<T>(int statusCode, Map<String, dynamic> json) {
  final error = json["error"] ?? json;
  final message = error["message"] ?? 'Unknown error';
  return ApiResponse.failure(
    ApiError.build(statusCode: statusCode, message: message),
  );
}
