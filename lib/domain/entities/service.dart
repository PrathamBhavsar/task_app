import 'package:json_annotation/json_annotation.dart';

import 'service_master.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  @JsonKey(name: 'task_service_id', includeIfNull: false)
  final int? serviceId;

  @JsonKey(name: 'task_id')
  final int taskId;

  @JsonKey(name: 'service_master', includeToJson: false)
  final ServiceMaster serviceMaster;

  @JsonKey(
    name: 'service_master_id',
    includeFromJson: false,
    includeToJson: true,
  )
  final int? serviceMasterId;

  final int quantity;

  @JsonKey(name: 'unit_price')
  final double rate;

  @JsonKey(name: 'total_amount')
  final double amount;

  Service({
    required this.taskId,
    required this.serviceMaster,
    required this.quantity,
    required this.rate,
    required this.amount,
    this.serviceId,
    this.serviceMasterId,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);

  Service copyWith({
    double? rate,
    int? quantity,
    double? amount,
    ServiceMaster? serviceMaster,
  }) {
    return Service(
      rate: rate ?? this.rate,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      serviceMaster: serviceMaster ?? this.serviceMaster,
      serviceMasterId: serviceMaster?.serviceMasterId ?? serviceMasterId,
      taskId: taskId,
    );
  }

  static Service empty(int taskId, ServiceMaster serviceMaster) => Service(
    quantity: 1,
    rate: serviceMaster.rate,
    amount: serviceMaster.rate,
    serviceMasterId: serviceMaster.serviceMasterId,
    taskId: taskId,
    serviceMaster: serviceMaster,
  );
}
