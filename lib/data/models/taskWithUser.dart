class TaskWithUsers {
  final String taskId;
  final String taskName;
  final String dueDate;
  final String statusName;
  final String statusColor;
  final String priorityName;
  final String priorityColor;
  final List<String> userNames;
  final List<String> userProfileBgColors;

  TaskWithUsers({
    required this.taskId,
    required this.taskName,
    required this.dueDate,
    required this.statusName,
    required this.statusColor,
    required this.priorityName,
    required this.priorityColor,
    required this.userNames,
    required this.userProfileBgColors,
  });

  factory TaskWithUsers.fromJson(Map<String, dynamic> json) => TaskWithUsers(
        taskId: json['task_id'],
        taskName: json['task_name'],
        dueDate: json['due_date'],
        statusName: json['status_name'],
        statusColor: json['status_color'],
        priorityName: json['priority_name'],
        priorityColor: json['priority_color'],
        userNames: (json['user_names'] as String?)?.split(',') ?? [],
        userProfileBgColors:
            (json['user_profile_bg_colors'] as String?)?.split(',') ?? [],
      );
}
