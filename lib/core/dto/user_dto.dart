import 'dto.dart';

class UserDTO extends ApiDTO {
  final String name;
  final String email;
  final String password;
  final String role;
  final String profileBgColor;

  UserDTO({
    required super.action,
    this.name = "",
    this.email = "",
    this.password = "",
    this.role = "",
    this.profileBgColor = "",
  });

  @override
  Map<String, dynamic> toJson() => {
        "action": action,
        "name": name,
        "email": email,
        "password": password,
        "role": role,
        "profile_bg_color": profileBgColor,
      };

  factory UserDTO.fromJson(Map<String, dynamic> json) => UserDTO(
        action: json["action"] ?? "",
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        role: json["role"] ?? "",
        profileBgColor: json["profile_bg_color"] ?? "",
      );
}
