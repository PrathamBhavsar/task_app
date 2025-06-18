import 'package:json_annotation/json_annotation.dart';

part 'auth_payload.g.dart';

@JsonSerializable()
class AuthPayload {
  final String email;
  final String password;

  const AuthPayload({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$AuthPayloadToJson(this);
}
