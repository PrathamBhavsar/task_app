import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/quote_measurement.dart';

part 'get_quote_measurements_response.g.dart';

@JsonSerializable()
class GetQuoteMeasurementResponse {
  @JsonKey(name: 'quote_measurements')
  final List<QuoteMeasurement> quoteMeasurements;

  GetQuoteMeasurementResponse({required this.quoteMeasurements});

  factory GetQuoteMeasurementResponse.fromJson(Map<String, dynamic> json) =>
      _$GetQuoteMeasurementResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetQuoteMeasurementResponseToJson(this);
}
