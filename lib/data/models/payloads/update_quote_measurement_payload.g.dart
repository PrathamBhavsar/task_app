// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_quote_measurement_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateQuoteMeasurementPayload _$UpdateQuoteMeasurementPayloadFromJson(
  Map<String, dynamic> json,
) => UpdateQuoteMeasurementPayload(
  quoteId: (json['id'] as num).toInt(),
  taskId: (json['task_id'] as num).toInt(),
  subtotal: (json['subtotal'] as num).toDouble(),
  tax: (json['tax'] as num).toDouble(),
  total: (json['total'] as num).toDouble(),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$UpdateQuoteMeasurementPayloadToJson(
  UpdateQuoteMeasurementPayload instance,
) => <String, dynamic>{
  'task_id': instance.taskId,
  'subtotal': instance.subtotal,
  'tax': instance.tax,
  'total': instance.total,
  'notes': instance.notes,
};
