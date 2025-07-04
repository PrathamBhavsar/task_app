// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bill _$BillFromJson(Map<String, dynamic> json) => Bill(
  taskId: (json['task_id'] as num).toInt(),
  total: (json['total'] as num).toDouble(),
  subtotal: (json['subtotal'] as num).toDouble(),
  tax: (json['tax'] as num).toDouble(),
  status: const BillStatusConverter().fromJson(json['status'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  dueDate: DateTime.parse(json['due_date'] as String),
  notes: json['additional_notes'] as String?,
  billId: (json['bill_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
  'bill_id': instance.billId,
  'task_id': instance.taskId,
  'due_date': instance.dueDate.toIso8601String(),
  'total': instance.total,
  'subtotal': instance.subtotal,
  'tax': instance.tax,
  'additional_notes': instance.notes,
  'status': const BillStatusConverter().toJson(instance.status),
  'created_at': instance.createdAt.toIso8601String(),
};
