// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementPayload _$MeasurementPayloadFromJson(Map<String, dynamic> json) =>
    MeasurementPayload(
      measurements:
          (json['measurements'] as List<dynamic>)
              .map((e) => Measurement.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$MeasurementPayloadToJson(MeasurementPayload instance) =>
    <String, dynamic>{'measurements': instance.measurements};
