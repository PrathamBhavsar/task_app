// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_quote_measurements_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetQuoteMeasurementResponse _$GetQuoteMeasurementResponseFromJson(
  Map<String, dynamic> json,
) => GetQuoteMeasurementResponse(
  quoteMeasurements:
      (json['quote_measurements'] as List<dynamic>)
          .map((e) => QuoteMeasurement.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GetQuoteMeasurementResponseToJson(
  GetQuoteMeasurementResponse instance,
) => <String, dynamic>{'quote_measurements': instance.quoteMeasurements};
