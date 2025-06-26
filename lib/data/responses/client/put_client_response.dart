import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/client.dart';
part 'put_client_response.g.dart';

@JsonSerializable()
class PutClientResponse {
  @JsonKey(name: 'client')
  final Client client;

  PutClientResponse({required this.client});

  factory PutClientResponse.fromJson(Map<String, dynamic> json) =>
      _$PutClientResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PutClientResponseToJson(this);
}
