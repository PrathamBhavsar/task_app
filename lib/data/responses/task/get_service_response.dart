import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/service.dart';

part 'get_service_response.g.dart';

@JsonSerializable()
class GetServiceResponse {
  @JsonKey(name: 'services')
  final List<Service> services;

  GetServiceResponse({required this.services});

  factory GetServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$GetServiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetServiceResponseToJson(this);
}
