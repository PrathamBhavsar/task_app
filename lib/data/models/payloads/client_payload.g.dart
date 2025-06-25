// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientPayload _$CustomerPayloadFromJson(Map<String, dynamic> json) =>
    ClientPayload(
      name: json['name'] as String,
      contactNo: json['contact_no'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$CustomerPayloadToJson(ClientPayload instance) =>
    <String, dynamic>{
      'name': instance.name,
      'contact_no': instance.contactNo,
      'email': instance.email,
      'address': instance.address,
    };
