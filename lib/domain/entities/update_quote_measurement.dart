import 'package:json_annotation/json_annotation.dart';


part 'update_quote_measurement.g.dart';

@JsonSerializable()
class UpdateQuoteMeasurement {
  @JsonKey(name: 'measurement_id')
  final int measurementId;

  @JsonKey(name: 'unit_price')
  final double unitPrice;
  final int quantity;

  final double discount;

  UpdateQuoteMeasurement({
    required this.measurementId,
    required this.unitPrice,
    required this.quantity,
    required this.discount,
  });

  factory UpdateQuoteMeasurement.fromJson(Map<String, dynamic> json) =>
      _$UpdateQuoteMeasurementFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateQuoteMeasurementToJson(this);

}
