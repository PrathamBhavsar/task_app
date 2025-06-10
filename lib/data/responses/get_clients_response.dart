import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/client.dart';

part 'get_clients_response.g.dart';

@JsonSerializable()
class GetClientsResponse {
  @JsonKey(name: 'clients')
  final List<Client> clients;

  GetClientsResponse({required this.clients});

  factory GetClientsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetClientsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetClientsResponseToJson(this);
}
