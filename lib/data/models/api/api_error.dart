import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError {
  final int statusCode;
  final String message;

  const ApiError({required this.statusCode, required this.message});

  factory ApiError.build({int? statusCode, String? message}) {
    return ApiError(
      statusCode: statusCode ?? 500,
      message: message ?? "An unknown error occurred",
    );
  }

  factory ApiError.fromException({
    required int statusCode,
    required Exception exception,
  }) {
    return ApiError(statusCode: statusCode, message: exception.toString());
  }

  factory ApiError.unknownError() {
    return ApiError(statusCode: 500, message: "An unknown error occurred");
  }

  factory ApiError.unauthorized() {
    return ApiError(statusCode: 401, message: "Unauthorized");
  }

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}
