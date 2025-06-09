import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'created_at')
  final String createdAt;

  final String name;
  final String email;
  final String password;

  @JsonKey(name: 'contact_no')
  final String contactNo;

  final String address;

  @JsonKey(name: 'user_type')
  final String userType;

  @JsonKey(name: 'profile_bg_color')
  final String profileBgColor;

  const User({
    required this.userId,
    required this.createdAt,
    required this.name,
    required this.email,
    required this.password,
    required this.contactNo,
    required this.address,
    required this.userType,
    required this.profileBgColor,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
    userId,
    createdAt,
    name,
    email,
    password,
    contactNo,
    address,
    userType,
    profileBgColor,
  ];
}
