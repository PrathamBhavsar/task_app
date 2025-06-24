// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  userId: (json['user_id'] as num?)?.toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  contactNo: json['contact_no'] as String,
  address: json['address'] as String,
  userType: const UserRoleConverter().fromJson(json['user_type'] as String),
  profileBgColor: json['profile_bg_color'] as String,
  createdAt:
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'user_id': instance.userId,
  'created_at': instance.createdAt?.toIso8601String(),
  'name': instance.name,
  'email': instance.email,
  'contact_no': instance.contactNo,
  'address': instance.address,
  'user_type': const UserRoleConverter().toJson(instance.userType),
  'profile_bg_color': instance.profileBgColor,
};
