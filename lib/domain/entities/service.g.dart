// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
  serviceType: json['service_type'] as String,
  quantity: (json['quantity'] as num).toInt(),
  rate: (json['rate'] as num).toDouble(),
  amount: (json['amount'] as num).toDouble(),
  serviceId: (json['service_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
  'service_id': instance.serviceId,
  'service_type': instance.serviceType,
  'quantity': instance.quantity,
  'rate': instance.rate,
  'amount': instance.amount,
};
