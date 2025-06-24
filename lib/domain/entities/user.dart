import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/enums/user_role.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  final String name;
  final String email;
  @JsonKey(name: 'contact_no')
  final String contactNo;

  final String address;

  @JsonKey(name: 'user_type')
  @UserRoleConverter()
  final UserRole userType;

  @JsonKey(name: 'profile_bg_color')
  final String profileBgColor;

  const User({
    required this.userId,

    required this.name,
    required this.email,

    required this.contactNo,
    required this.address,
    required this.userType,
    required this.profileBgColor,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
    userId,
    createdAt,
    name,
    email,
    contactNo,
    address,
    userType,
    profileBgColor,
  ];
}

class UserRoleConverter implements JsonConverter<UserRole, String> {
  const UserRoleConverter();

  @override
  UserRole fromJson(String json) => UserRole.fromString(json);

  @override
  String toJson(UserRole role) => role.role;
}