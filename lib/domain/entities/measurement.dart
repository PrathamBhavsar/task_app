import 'package:json_annotation/json_annotation.dart';

part 'measurement.g.dart';

@JsonSerializable()
class Measurement {
  @JsonKey(name: 'measurement_id', includeIfNull: false)
  final int? measurementId;

  final String location;
  final double width;
  final double height;
  final double area;
  final String unit;
  final String? notes;

  @JsonKey(name: 'task_id')
  final int taskId;

  @JsonKey(name: 'unit_price')
  final double rate;
  final int quantity;

  @JsonKey(name: 'total_price')
  final double totalPrice;

  final double discount;

  Measurement({
    required this.location,
    required this.width,
    required this.height,
    required this.area,
    required this.unit,
    required this.taskId,
    required this.rate,
    required this.quantity,
    required this.discount,
    required this.totalPrice,
    this.notes,
    this.measurementId,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) =>
      _$MeasurementFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementToJson(this);

  Measurement copyWith({
    String? location,
    String? notes,
    String? unit,
    double? height,
    double? area,
    double? width,
    double? rate,
    int? quantity,
    double? totalPrice,
    double? discount,
  }) {
    return Measurement(
      location: location ?? this.location,
      width: width ?? this.width,
      height: height ?? this.height,
      area: area ?? this.area,
      unit: unit ?? this.unit,
      notes: notes ?? this.notes,
      rate: rate ?? this.rate,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
      totalPrice: totalPrice ?? this.totalPrice,
      taskId: taskId,
    );
  }

  static Measurement empty(int taskId) => Measurement(
    location: '',
    width: 0.00,
    height: 0.00,
    notes: '',
    taskId: taskId,
    area: 0.00,
    unit: 'm',
    rate: 0.00,
    discount: 0.00,
    totalPrice: 0.00,
    quantity: 1,
  );
}
