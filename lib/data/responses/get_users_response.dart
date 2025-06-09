import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'get_users_response.g.dart';

@JsonSerializable()
class GetUsersResponse {
  @JsonKey(name: 'users')
  final List<User> users;

  GetUsersResponse({required this.users});

  factory GetUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUsersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUsersResponseToJson(this);
}
