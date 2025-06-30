// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) => Quote(
  total: (json['total'] as num).toDouble(),
  taskId: (json['task_id'] as num).toInt(),
  subtotal: (json['subtotal'] as num).toDouble(),
  tax: (json['tax'] as num).toDouble(),
  createdAt: DateTime.parse(json['created_at'] as String),
  notes: json['notes'] as String?,
  quoteId: (json['quote_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
  'quote_id': instance.quoteId,
  'task_id': instance.taskId,
  'total': instance.total,
  'subtotal': instance.subtotal,
  'tax': instance.tax,
  'notes': instance.notes,
  'created_at': instance.createdAt.toIso8601String(),
};
