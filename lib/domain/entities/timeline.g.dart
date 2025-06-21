// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timeline _$TimelineFromJson(Map<String, dynamic> json) => Timeline(
  taskId: (json['task_id'] as num).toInt(),
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  status: Status.fromJson(json['status'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['created_at'] as String),
  timelineId: (json['timeline_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$TimelineToJson(Timeline instance) => <String, dynamic>{
  'timeline_id': instance.timelineId,
  'task_id': instance.taskId,
  'user': instance.user,
  'status': instance.status,
  'created_at': instance.createdAt.toIso8601String(),
};
