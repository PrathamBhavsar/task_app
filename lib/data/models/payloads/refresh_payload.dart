import 'package:json_annotation/json_annotation.dart';

part 'refresh_payload.g.dart';

@JsonSerializable()
class RefreshPayload {
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  const RefreshPayload({required this.refreshToken});

  Map<String, dynamic> toJson() => _$RefreshPayloadToJson(this);
}
