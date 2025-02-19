class TaskUser {
  final String userId;
  final String taskId;
  final DateTime createdAt;

  TaskUser({
    required this.userId,
    required this.taskId,
    required this.createdAt,
  });

  factory TaskUser.fromJson(Map<String, dynamic> json) => TaskUser(
        userId: json['user_id'],
        taskId: json['task_id'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'task_id': taskId,
        'created_at': createdAt.toIso8601String(),
      };
}
