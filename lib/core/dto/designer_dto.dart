import '../constants/enums/dto_action.dart';
import 'dto.dart';

class CreateDesignerDTO extends ApiDTO {
  final String code;
  final String name;
  final String firmName;
  final String address;
  final String contactNo;
  final String profileBgColor;

  CreateDesignerDTO({
    required this.code,
    required this.name,
    required this.firmName,
    required this.address,
    required this.contactNo,
    required this.profileBgColor,
  }) : super(action: DtoAction.create);

  @override
  Map<String, dynamic> toJson() => {
        "action": action.action,
        "code": code,
        "name": name,
        "firm_name": firmName,
        "address": address,
        "contact_no": contactNo,
        "profile_bg_color": profileBgColor,
      };
}

class UpdateDesignerDTO extends ApiDTO {
  final String id;
  final String code;
  final String name;
  final String firmName;
  final String address;
  final String contactNo;
  final String profileBgColor;

  UpdateDesignerDTO({
    required this.id,
    required this.code,
    required this.name,
    required this.firmName,
    required this.address,
    required this.contactNo,
    required this.profileBgColor,
  }) : super(action: DtoAction.update);

  @override
  Map<String, dynamic> toJson() => {
        "action": action.action,
        "id": id,
        "code": code,
        "name": name,
        "firm_name": firmName,
        "address": address,
        "contact_no": contactNo,
        "profile_bg_color": profileBgColor,
      };
}

class DeleteDesignerDTO extends ApiDTO {
  final String id;

  DeleteDesignerDTO({required this.id}) : super(action: DtoAction.delete);

  @override
  Map<String, dynamic> toJson() => {
        "action": action.action,
        "id": id,
      };
}
