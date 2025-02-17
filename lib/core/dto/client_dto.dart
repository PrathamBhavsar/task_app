import 'dto.dart';

class ClientDTO extends ApiDTO {
  final String name;

  final String address;
  final String contactNo;

  ClientDTO({
    required super.action,
    required this.name,
    required this.address,
    required this.contactNo,
  });

  @override
  Map<String, dynamic> toJson() => {
        "action": action,
        "name": name,
        "address": address,
        "contact_no": contactNo,
      };

  factory ClientDTO.fromJson(Map<String, dynamic> json) => ClientDTO(
        action: json["action"] ?? "",
        name: json["name"] ?? "",
        address: json["address"] ?? "",
        contactNo: json["contact_no"] ?? "",
      );
}
