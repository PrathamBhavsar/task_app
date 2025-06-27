// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Measurement _$MeasurementFromJson(Map<String, dynamic> json) => Measurement(
  location: json['location'] as String,
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  notes: json['notes'] as String,
  taskId: (json['task_id'] as num).toInt(),
  measurementId: (json['measurement_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$MeasurementToJson(Measurement instance) =>
    <String, dynamic>{
      'measurement_id': instance.measurementId,
      'location': instance.location,
      'width': instance.width,
      'height': instance.height,
      'notes': instance.notes,
      'task_id': instance.taskId,
    };
