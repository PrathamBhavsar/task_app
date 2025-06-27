// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
  taskId: (json['task_id'] as num).toInt(),
  serviceType: json['service_type'] as String,
  serviceMaster: ServiceMaster.fromJson(
    json['service_master'] as Map<String, dynamic>,
  ),
  quantity: (json['quantity'] as num).toInt(),
  rate: (json['rate'] as num).toDouble(),
  amount: (json['amount'] as num).toDouble(),
  serviceId: (json['task_service_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
  if (instance.serviceId case final value?) 'task_service_id': value,
  'task_id': instance.taskId,
  'service_master': instance.serviceMaster,
  'service_type': instance.serviceType,
  'quantity': instance.quantity,
  'rate': instance.rate,
  'amount': instance.amount,
};
