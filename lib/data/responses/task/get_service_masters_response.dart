import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/service_master.dart';

part 'get_service_masters_response.g.dart';

@JsonSerializable()
class GetServiceMastersResponse {
  @JsonKey(name: 'service masters')
  final List<ServiceMaster> serviceMasters;

  GetServiceMastersResponse({required this.serviceMasters});

  factory GetServiceMastersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetServiceMastersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetServiceMastersResponseToJson(this);
}
