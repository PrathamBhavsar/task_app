import '../../utils/constants/enums/dto_action.dart';
import 'dto.dart';

class LoginUserDTO extends ApiDTO {
  final String email;
  final String password;

  LoginUserDTO({
    required this.email,
    required this.password,
  }) : super(action: DtoAction.login);

  @override
  Map<String, dynamic> toJson() => {
        "action": action.action,
        "email": email,
        "password": password,
      };

  factory LoginUserDTO.fromJson(Map<String, dynamic> json) => LoginUserDTO(
        email: json["email"] ?? "",
        password: json["password"] ?? "",
      );
}
