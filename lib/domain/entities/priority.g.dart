// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priority.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Priority _$PriorityFromJson(Map<String, dynamic> json) => Priority(
  priorityId: (json['priority_id'] as num?)?.toInt(),
  name: json['name'] as String,
  color: json['color'] as String,
);

Map<String, dynamic> _$PriorityToJson(Priority instance) => <String, dynamic>{
  'priority_id': instance.priorityId,
  'name': instance.name,
  'color': instance.color,
};
