// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bill _$BillFromJson(Map<String, dynamic> json) => Bill(
  total: (json['total'] as num).toDouble(),
  subtotal: (json['subtotal'] as num).toDouble(),
  tax: (json['tax'] as num).toDouble(),
  status: json['status'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  dueDate: DateTime.parse(json['due_date'] as String),
  notes: json['additional_notes'] as String?,
  billId: (json['bill_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
  'bill_id': instance.billId,
  'due_date': instance.dueDate.toIso8601String(),
  'total': instance.total,
  'subtotal': instance.subtotal,
  'tax': instance.tax,
  'additional_notes': instance.notes,
  'status': instance.status,
  'created_at': instance.createdAt.toIso8601String(),
};
