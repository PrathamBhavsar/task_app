class UserModel {
  final String? id;
  final String name;
  final String email;
  final String profileBgColor;
  final String role;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.profileBgColor,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileBgColor: json['profile_bg_color'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_bg_color': profileBgColor,
      'role': role,
    };
  }
}
