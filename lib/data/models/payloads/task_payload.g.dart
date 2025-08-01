// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskPayload _$TaskPayloadFromJson(Map<String, dynamic> json) => TaskPayload(
  assignedUsers:
      (json['assigned_users'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
  name: json['name'] as String,
  startDate: DateTime.parse(json['start_date'] as String),
  dueDate: DateTime.parse(json['due_date'] as String),
  priority: json['priority'] as String,
  status: json['status'] as String,
  createdById: (json['created_by'] as num).toInt(),
  clientId: (json['client_id'] as num).toInt(),
  designerId: (json['designer_id'] as num).toInt(),
  remarks: json['remarks'] as String?,
  agencyId: (json['agency_id'] as num?)?.toInt(),
  taskId: (json['task_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$TaskPayloadToJson(TaskPayload instance) =>
    <String, dynamic>{
      if (instance.taskId case final value?) 'task_id': value,
      'name': instance.name,
      'start_date': instance.startDate.toIso8601String(),
      'due_date': instance.dueDate.toIso8601String(),
      'priority': instance.priority,
      'remarks': instance.remarks,
      'status': instance.status,
      'created_by': instance.createdById,
      'client_id': instance.clientId,
      'designer_id': instance.designerId,
      if (instance.agencyId case final value?) 'agency_id': value,
      'assigned_users': instance.assignedUsers,
    };
