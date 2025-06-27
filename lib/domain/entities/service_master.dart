import 'package:json_annotation/json_annotation.dart';

part 'service_master.g.dart';

@JsonSerializable()
class ServiceMaster {
  @JsonKey(name: 'service_master_id')
  final int? serviceMasterId;

  final String name;

  @JsonKey(name: 'default_rate')
  final double rate;

  ServiceMaster({
    required this.name,
    required this.rate,
    this.serviceMasterId,
  });

  factory ServiceMaster.fromJson(Map<String, dynamic> json) =>
      _$ServiceMasterFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceMasterToJson(this);
}
