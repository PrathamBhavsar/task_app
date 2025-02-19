import '../../utils/constants/enums/dto_action.dart';
import 'dto.dart';

class CreateClientDTO extends ApiDTO {
  final String name;
  final String address;
  final String contactNo;

  CreateClientDTO({
    required this.name,
    required this.address,
    required this.contactNo,
  }) : super(action: DtoAction.create);

  @override
  Map<String, dynamic> toJson() => {
        "action": action.action,
        "name": name,
        "address": address,
        "contact_no": contactNo,
      };
}

class UpdateClientDTO extends ApiDTO {
  final String id;
  final String name;
  final String address;
  final String contactNo;

  UpdateClientDTO({
    required this.id,
    required this.name,
    required this.address,
    required this.contactNo,
  }) : super(action: DtoAction.update);

  @override
  Map<String, dynamic> toJson() => {
        "action": action.action,
        "id": id,
        "name": name,
        "address": address,
        "contact_no": contactNo,
      };
}

class DeleteClientDTO extends ApiDTO {
  final String id;

  DeleteClientDTO({required this.id}) : super(action: DtoAction.delete);

  @override
  Map<String, dynamic> toJson() => {
        "action": action.action,
        "id": id,
      };
}
