// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteMeasurement _$QuoteMeasurementFromJson(Map<String, dynamic> json) =>
    QuoteMeasurement(
      measurement: Measurement.fromJson(
        json['measurement'] as Map<String, dynamic>,
      ),
      rate: (json['rate'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      discount: (json['discount'] as num).toDouble(),
      totalPrice: (json['total_price'] as num).toDouble(),
      taskId: (json['task_id'] as num).toInt(),
    );

Map<String, dynamic> _$QuoteMeasurementToJson(QuoteMeasurement instance) =>
    <String, dynamic>{
      'measurement': instance.measurement,
      'rate': instance.rate,
      'quantity': instance.quantity,
      'total_price': instance.totalPrice,
      'discount': instance.discount,
      'task_id': instance.taskId,
    };
