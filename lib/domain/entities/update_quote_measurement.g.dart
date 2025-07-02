// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_quote_measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateQuoteMeasurement _$UpdateQuoteMeasurementFromJson(
  Map<String, dynamic> json,
) => UpdateQuoteMeasurement(
  measurementId: (json['measurement_id'] as num).toInt(),
  unitPrice: (json['unit_price'] as num).toDouble(),
  quantity: (json['quantity'] as num).toInt(),
  discount: (json['discount'] as num).toDouble(),
);

Map<String, dynamic> _$UpdateQuoteMeasurementToJson(
  UpdateQuoteMeasurement instance,
) => <String, dynamic>{
  'measurement_id': instance.measurementId,
  'unit_price': instance.unitPrice,
  'quantity': instance.quantity,
  'discount': instance.discount,
};
