// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
  taskId: (json['task_id'] as num).toInt(),
  serviceMaster: ServiceMaster.fromJson(
    json['service_master'] as Map<String, dynamic>,
  ),
  quantity: (json['quantity'] as num).toInt(),
  rate: (json['unit_price'] as num).toDouble(),
  amount: (json['total_amount'] as num).toDouble(),
  serviceId: (json['task_service_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
  if (instance.serviceId case final value?) 'task_service_id': value,
  'task_id': instance.taskId,
  'service_master_id': instance.serviceMasterId,
  'quantity': instance.quantity,
  'unit_price': instance.rate,
  'total_amount': instance.amount,
};
