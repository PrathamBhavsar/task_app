// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_master.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceMaster _$ServiceMasterFromJson(Map<String, dynamic> json) =>
    ServiceMaster(
      name: json['name'] as String,
      rate: (json['default_rate'] as num).toDouble(),
      serviceMasterId: (json['service_master_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ServiceMasterToJson(ServiceMaster instance) =>
    <String, dynamic>{
      'service_master_id': instance.serviceMasterId,
      'name': instance.name,
      'default_rate': instance.rate,
    };
