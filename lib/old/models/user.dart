import '../../core/constants/enums/user_role.dart';

class UserModel {
  final String? id;
  final String name;
  final UserRole role;
  final String email;
  final String? taskId;
  final DateTime? createdAt;
  final String profileBgColor;

  UserModel({
    this.id,
    required this.name,
    required this.role,
    required this.email,
    this.taskId,
    this.createdAt,
    required this.profileBgColor,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        role: UserRole.fromString(json['role']),
        email: json['email'],
        taskId: json['task_id'],
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        profileBgColor: json['profile_bg_color'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role.role,
        'email': email,
        'task_id': taskId,
        'created_at': createdAt?.toIso8601String(),
        'profile_bg_color': profileBgColor,
      };
}
