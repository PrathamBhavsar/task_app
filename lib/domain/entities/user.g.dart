// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
  userId: (json['user_id'] as num).toInt(),
  createdAt: json['created_at'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  contactNo: json['contact_no'] as String,
  address: json['address'] as String,
  userType: json['user_type'] as String,
  profileBgColor: json['profile_bg_color'] as String,
);

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
  'user_id': instance.userId,
  'created_at': instance.createdAt,
  'name': instance.name,
  'email': instance.email,
  'password': instance.password,
  'contact_no': instance.contactNo,
  'address': instance.address,
  'user_type': instance.userType,
  'profile_bg_color': instance.profileBgColor,
};
