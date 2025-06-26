import 'package:json_annotation/json_annotation.dart';

part 'client_payload.g.dart';

@JsonSerializable()
class ClientPayload {
  final String name;

  @JsonKey(name: 'contact_no')
  final String contactNo;

  final String email;
  final String address;

  const ClientPayload({
    required this.name,
    required this.contactNo,
    required this.email,
    required this.address,
  });

  Map<String, dynamic> toJson() => _$ClientPayloadToJson(this);
}
