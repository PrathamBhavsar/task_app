// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_quote_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateQuotePayload _$UpdateQuotePayloadFromJson(Map<String, dynamic> json) =>
    UpdateQuotePayload(
      quoteId: (json['id'] as num).toInt(),
      taskId: (json['task_id'] as num).toInt(),
      subtotal: (json['subtotal'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$UpdateQuotePayloadToJson(UpdateQuotePayload instance) =>
    <String, dynamic>{
      'task_id': instance.taskId,
      'subtotal': instance.subtotal,
      'tax': instance.tax,
      'total': instance.total,
      'notes': instance.notes,
    };
