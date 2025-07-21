// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Measurement _$MeasurementFromJson(Map<String, dynamic> json) => Measurement(
  location: json['location'] as String,
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  area: (json['area'] as num).toDouble(),
  unit: json['unit'] as String,
  taskId: (json['task_id'] as num).toInt(),
  rate: (json['unit_price'] as num).toDouble(),
  quantity: (json['quantity'] as num).toInt(),
  discount: (json['discount'] as num).toDouble(),
  totalPrice: (json['total_price'] as num).toDouble(),
  notes: json['notes'] as String?,
  measurementId: (json['measurement_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$MeasurementToJson(Measurement instance) =>
    <String, dynamic>{
      if (instance.measurementId case final value?) 'measurement_id': value,
      'location': instance.location,
      'width': instance.width,
      'height': instance.height,
      'area': instance.area,
      'unit': instance.unit,
      'notes': instance.notes,
      'task_id': instance.taskId,
      'unit_price': instance.rate,
      'quantity': instance.quantity,
      'total_price': instance.totalPrice,
      'discount': instance.discount,
    };
