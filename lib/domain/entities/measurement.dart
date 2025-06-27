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

  @JsonKey(name: 'task_id')
  final int taskId;

  Measurement({
    required this.location,
    required this.width,
    required this.height,
    required this.notes,
    required this.taskId,
    this.measurementId,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) =>
      _$MeasurementFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementToJson(this);

  static Measurement empty(int taskId) => Measurement(
    location: '',
    width: 0.00,
    height: 0.00,
    notes: '',
    taskId: taskId,
  );
}
