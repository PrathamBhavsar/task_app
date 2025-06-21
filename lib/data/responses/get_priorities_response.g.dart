// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_priorities_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPrioritiesResponse _$GetPrioritiesResponseFromJson(
  Map<String, dynamic> json,
) => GetPrioritiesResponse(
  priorities:
      (json['prioritys'] as List<dynamic>)
          .map((e) => Priority.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GetPrioritiesResponseToJson(
  GetPrioritiesResponse instance,
) => <String, dynamic>{'prioritys': instance.priorities};
