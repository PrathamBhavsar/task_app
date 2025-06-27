import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/measurement.dart';

part 'get_measurement_response.g.dart';

@JsonSerializable()
class GetMeasurementResponse {
  @JsonKey(name: 'measurements')
  final List<Measurement> measurements;

  GetMeasurementResponse({required this.measurements});

  factory GetMeasurementResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMeasurementResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMeasurementResponseToJson(this);
}
