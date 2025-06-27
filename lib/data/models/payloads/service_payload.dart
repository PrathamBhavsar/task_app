import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/service.dart';

part 'service_payload.g.dart';

  @JsonSerializable()
  class ServicePayload {
    final List<Service> services;

    const ServicePayload({required this.services});

    Map<String, dynamic> toJson() => _$ServicePayloadToJson(this);
  }
