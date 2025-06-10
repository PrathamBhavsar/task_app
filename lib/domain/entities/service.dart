import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  @JsonKey(name: 'service_id')
  final int? serviceId;

  @JsonKey(name: 'service_type')
  final String serviceType;

  final int quantity;
  final double rate;
  final double amount;

  Service({
    required this.serviceType,
    required this.quantity,
    required this.rate,
    required this.amount,
    this.serviceId,
  });

  /// JSON serialization
  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);

  /// Empty factory
  static Service get empty =>
      Service(serviceType: '', quantity: 0, rate: 0.00, amount: 0.00);
}
