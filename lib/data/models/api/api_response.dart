import 'package:json_annotation/json_annotation.dart';

import 'api_error.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  T? data;
  ApiError? error;

  ApiResponse({this.data, this.error});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  factory ApiResponse.success(T? data) => ApiResponse(data: data);

  factory ApiResponse.failure(ApiError error) => ApiResponse(error: error);

  bool get isSuccess => error == null;
}
