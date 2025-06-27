// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_measurement_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMeasurementResponse _$GetMeasurementResponseFromJson(
  Map<String, dynamic> json,
) => GetMeasurementResponse(
  measurements:
      (json['measurements'] as List<dynamic>)
          .map((e) => Measurement.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GetMeasurementResponseToJson(
  GetMeasurementResponse instance,
) => <String, dynamic>{'measurements': instance.measurements};
