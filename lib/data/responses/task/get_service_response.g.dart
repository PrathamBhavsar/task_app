// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetServiceResponse _$GetServiceResponseFromJson(Map<String, dynamic> json) =>
    GetServiceResponse(
      services:
          (json['services'] as List<dynamic>)
              .map((e) => Service.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$GetServiceResponseToJson(GetServiceResponse instance) =>
    <String, dynamic>{'services': instance.services};
