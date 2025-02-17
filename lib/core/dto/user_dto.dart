import '../constants/enums/dto_action.dart';
import '../constants/enums/user_role.dart';
import 'dto.dart';

class CreateUserDTO extends ApiDTO {
  final String name;
  final String email;
  final String password;
  final UserRole role;
  final String profileBgColor;

  CreateUserDTO({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.profileBgColor,
  }) : super(action: DtoAction.create);

  @override
  Map<String, dynamic> toJson() => {
        "action": action.action,
        "name": name,
        "email": email,
        "password": password,
        "role": role,
        "profile_bg_color": profileBgColor,
      };
}

class UpdateUserDTO extends ApiDTO {
  final String id;
  final String name;
  final String email;
  final String password;
  final UserRole role;
  final String profileBgColor;

  UpdateUserDTO({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.profileBgColor,
  }) : super(action: DtoAction.update);

  @override
  Map<String, dynamic> toJson() => {
        "action": action.action,
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "role": role,
        "profile_bg_color": profileBgColor,
      };
}

class DeleteUserDTO extends ApiDTO {
  final String id;

  DeleteUserDTO({required this.id}) : super(action: DtoAction.delete);

  @override
  Map<String, dynamic> toJson() => {
        "action": action.action,
        "id": id,
      };
}
