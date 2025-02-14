class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String profileBgColor;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.profileBgColor,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        role: json['role'],
        profileBgColor: json['profile_bg_color'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        'profile_bg_color': profileBgColor,
        'created_at': createdAt.toIso8601String(),
      };
}
