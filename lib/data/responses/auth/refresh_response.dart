import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/user.dart';

part 'refresh_response.g.dart';

@JsonSerializable()
class RefreshResponse {
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'access_token')
  final String accessToken;

  RefreshResponse({required this.refreshToken, required this.accessToken});

  factory RefreshResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshResponseToJson(this);
}
