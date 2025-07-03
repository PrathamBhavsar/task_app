import 'package:json_annotation/json_annotation.dart';

import 'measurement.dart';

part 'quote_measurement.g.dart';

@JsonSerializable()
class QuoteMeasurement {
  @JsonKey(name: 'measurement')
  final Measurement measurement;

  final double rate;
  final int quantity;

  @JsonKey(name: 'total_price')
  final double totalPrice;

  final double discount;

  @JsonKey(name: 'task_id')
  final int taskId;

  QuoteMeasurement({
    required this.measurement,
    required this.rate,
    required this.quantity,
    required this.discount,
    required this.totalPrice,
    required this.taskId,
  });

  factory QuoteMeasurement.fromJson(Map<String, dynamic> json) =>
      _$QuoteMeasurementFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteMeasurementToJson(this);

  QuoteMeasurement copyWith({double? rate, int? quantity, double? totalPrice, double? discount}) {
    return QuoteMeasurement(
      rate: rate ?? this.rate,
      discount: discount ?? this.discount,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      measurement: measurement,
      taskId: taskId,
    );
  }

  static QuoteMeasurement empty(int taskId, Measurement measurement) =>
      QuoteMeasurement(
        rate: 0.00,
        discount: 0.00,
        totalPrice: 0.00,
        quantity: 1,
        measurement: measurement,
        taskId: taskId,
      );
}
