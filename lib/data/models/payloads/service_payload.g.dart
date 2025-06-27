// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicePayload _$ServicePayloadFromJson(Map<String, dynamic> json) =>
    ServicePayload(
      services:
          (json['services'] as List<dynamic>)
              .map((e) => Service.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ServicePayloadToJson(ServicePayload instance) =>
    <String, dynamic>{'services': instance.services};
