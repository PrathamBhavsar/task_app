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
  dealNo: json['deal_no'] as String,
  name: json['name'] as String,
  startDate: json['start_date'] as String,
  dueDate: json['due_date'] as String,
  priority: json['priority'] as String,
  status: json['status'] as String,
  createdById: (json['created_by'] as num).toInt(),
  clientId: (json['client_id'] as num).toInt(),
  designerId: (json['designer_id'] as num).toInt(),
  remarks: json['remarks'] as String?,
  agencyId: (json['agency_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$TaskPayloadToJson(TaskPayload instance) =>
    <String, dynamic>{
      'deal_no': instance.dealNo,
      'name': instance.name,
      'start_date': instance.startDate,
      'due_date': instance.dueDate,
      'priority': instance.priority,
      if (instance.remarks case final value?) 'remarks': value,
      'status': instance.status,
      'created_by': instance.createdById,
      'client_id': instance.clientId,
      'designer_id': instance.designerId,
      if (instance.agencyId case final value?) 'agency_id': value,
      'assigned_users': instance.assignedUsers,
    };
