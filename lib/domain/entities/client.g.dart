// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
  clientId: (json['client_id'] as num?)?.toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  contactNo: json['contact_no'] as String,
  address: json['address'] as String,
);

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
  'client_id': instance.clientId,
  'name': instance.name,
  'email': instance.email,
  'contact_no': instance.contactNo,
  'address': instance.address,
};
