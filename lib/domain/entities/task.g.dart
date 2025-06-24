// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
  taskId: (json['task_id'] as num?)?.toInt(),
  dealNo: json['deal_no'] as String,
  client: Client.fromJson(json['client'] as Map<String, dynamic>),
  designer: Designer.fromJson(json['designer'] as Map<String, dynamic>),
  assignedUsers:
      (json['assigned_users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
  name: json['name'] as String,
  status: const StatusConverter().fromJson(json['status'] as String),
  priority: const PriorityConverter().fromJson(json['priority'] as String),
  dueDate: DateTime.parse(json['due_date'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  agency:
      json['agency'] == null
          ? null
          : User.fromJson(json['agency'] as Map<String, dynamic>),
  remarks: json['remarks'] as String?,
);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  'task_id': instance.taskId,
  'deal_no': instance.dealNo,
  'name': instance.name,
  'created_at': instance.createdAt.toIso8601String(),
  'due_date': instance.dueDate.toIso8601String(),
  'priority': const PriorityConverter().toJson(instance.priority),
  'status': const StatusConverter().toJson(instance.status),
  'client': instance.client.toJson(),
  'agency': instance.agency?.toJson(),
  'designer': instance.designer.toJson(),
  'assigned_users': instance.assignedUsers.map((e) => e.toJson()).toList(),
  'remarks': instance.remarks,
};
