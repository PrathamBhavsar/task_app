import '../../utils/constants/enums/dto_action.dart';
import '../../utils/constants/enums/user_role.dart';
import 'dto.dart';

class RegisterUserDTO extends ApiDTO {
  final String name;
  final String email;
  final String password;
  final UserRole role;
  final String profileBgColor;

  RegisterUserDTO({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.profileBgColor,
  }) : super(action: DtoAction.register);

  @override
  Map<String, dynamic> toJson() => {
        "action": action.action,
        "name": name,
        "email": email,
        "password": password,
        "role": role.role,
        "profile_bg_color": profileBgColor,
      };

  factory RegisterUserDTO.fromJson(Map<String, dynamic> json) =>
      RegisterUserDTO(
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        role: UserRole.values.firstWhere(
          (e) => e.role == json["role"],
          orElse: () => UserRole.salesperson,
        ),
        profileBgColor: json["profile_bg_color"] ?? "",
      );
}
