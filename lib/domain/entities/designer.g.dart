// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'designer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Designer _$DesignerFromJson(Map<String, dynamic> json) => Designer(
  name: json['name'] as String,
  firmName: json['firm_name'] as String,
  contactNo: json['contact_no'] as String,
  address: json['address'] as String,
  profileBgColor: json['profile_bg_color'] as String,
  designerId: (json['designer_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$DesignerToJson(Designer instance) => <String, dynamic>{
  'designer_id': instance.designerId,
  'name': instance.name,
  'firm_name': instance.firmName,
  'contact_no': instance.contactNo,
  'address': instance.address,
  'profile_bg_color': instance.profileBgColor,
};
