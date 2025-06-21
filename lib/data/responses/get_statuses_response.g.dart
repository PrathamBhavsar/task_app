// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_statuses_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStatusesResponse _$GetStatusesResponseFromJson(Map<String, dynamic> json) =>
    GetStatusesResponse(
      statuses:
          (json['statuss'] as List<dynamic>)
              .map((e) => Status.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$GetStatusesResponseToJson(
  GetStatusesResponse instance,
) => <String, dynamic>{'statuss': instance.statuses};
