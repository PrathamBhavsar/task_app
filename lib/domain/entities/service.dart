import 'package:json_annotation/json_annotation.dart';

import 'service_master.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  @JsonKey(name: 'task_service_id', includeIfNull: false)
  final int? serviceId;

  @JsonKey(name: 'task_id')
  final int taskId;

  @JsonKey(name: 'service_master')
  final ServiceMaster serviceMaster;

  @JsonKey(name: 'service_type')
  final String serviceType;

  final int quantity;

  @JsonKey(name: 'unit_price')
  final double rate;
  final double amount;

  Service({
    required this.taskId,
    required this.serviceType,
    required this.serviceMaster,
    required this.quantity,
    required this.rate,
    required this.amount,
    this.serviceId,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);

  static Service empty(int taskId, ServiceMaster serviceMaster) => Service(
    serviceType: serviceMaster.name,
    quantity: 0,
    rate: serviceMaster.rate,
    amount: 0.00,
    taskId: taskId,
    serviceMaster: serviceMaster,
  );
}
