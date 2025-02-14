import 'dto.dart';

class DesignerDTO extends ApiDTO {
  final String code;
  final String name;
  final String firmName;
  final String address;
  final String contactNo;
  final String profileBgColor;

  DesignerDTO({
    required super.action,
    required this.code,
    required this.name,
    required this.firmName,
    required this.address,
    required this.contactNo,
    required this.profileBgColor,
  });

  @override
  Map<String, dynamic> toJson() => {
        "action": action,
        "code": code,
        "name": name,
        "firm_name": firmName,
        "address": address,
        "contact_no": contactNo,
        "profile_bg_color": profileBgColor,
      };

  factory DesignerDTO.fromJson(Map<String, dynamic> json) => DesignerDTO(
        action: json["action"] ?? "",
        code: json["code"] ?? "",
        name: json["name"] ?? "",
        firmName: json["firm_name"] ?? "",
        address: json["address"] ?? "",
        contactNo: json["contact_no"] ?? "",
        profileBgColor: json["profile_bg_color"] ?? "",
      );
}
