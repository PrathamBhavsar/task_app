import 'package:json_annotation/json_annotation.dart';

part 'measurement.g.dart';

@JsonSerializable()
class Measurement {
  @JsonKey(name: 'measurement_id')
  final int? measurementId;

  final String location;
  final double width;
  final double height;
  final String notes;

  Measurement({
    required this.measurementId,
    required this.location,
    required this.width,
    required this.height,
    required this.notes,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) =>
      _$MeasurementFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementToJson(this);

  static Measurement get empty => Measurement(
    measurementId: -1,
    location: '',
    width: 0.00,
    height: 0.00,
    notes: '',
  );
}
