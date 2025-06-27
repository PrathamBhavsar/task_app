import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/measurement.dart';

part 'measurement_payload.g.dart';

  @JsonSerializable()
  class MeasurementPayload {
    final List<Measurement> measurements;

    const MeasurementPayload({required this.measurements});

    Map<String, dynamic> toJson() => _$MeasurementPayloadToJson(this);
  }
