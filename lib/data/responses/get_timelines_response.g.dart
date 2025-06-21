// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_timelines_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTimelinesResponse _$GetTimelinesResponseFromJson(
  Map<String, dynamic> json,
) => GetTimelinesResponse(
  timelines:
      (json['timelines'] as List<dynamic>)
          .map((e) => Timeline.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GetTimelinesResponseToJson(
  GetTimelinesResponse instance,
) => <String, dynamic>{'timelines': instance.timelines};
