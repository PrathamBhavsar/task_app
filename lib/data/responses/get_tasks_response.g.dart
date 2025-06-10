// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tasks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTasksResponse _$GetTasksResponseFromJson(Map<String, dynamic> json) =>
    GetTasksResponse(
      tasks:
          (json['tasks'] as List<dynamic>)
              .map((e) => Task.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$GetTasksResponseToJson(GetTasksResponse instance) =>
    <String, dynamic>{'tasks': instance.tasks};
