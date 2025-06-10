import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client extends Equatable {
  @JsonKey(name: 'client_id')
  final int? clientId;
  final String name;
  final String email;

  @JsonKey(name: 'contact_no')
  final String contactNo;

  final String address;

  const Client({
    required this.clientId,
    required this.name,
    required this.email,
    required this.contactNo,
    required this.address,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);

  @override
  List<Object?> get props => [clientId, name, email, contactNo, address];
}
