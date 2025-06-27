// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_service_masters_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetServiceMastersResponse _$GetServiceMastersResponseFromJson(
  Map<String, dynamic> json,
) => GetServiceMastersResponse(
  serviceMasters:
      (json['service masters'] as List<dynamic>)
          .map((e) => ServiceMaster.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GetServiceMastersResponseToJson(
  GetServiceMastersResponse instance,
) => <String, dynamic>{'service masters': instance.serviceMasters};
