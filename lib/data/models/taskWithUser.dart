class TaskWithUsers {
  final String taskId;
  final String taskName;
  final String dueDate;
  final String statusName;
  final String statusColor;
  final String priorityName;
  final String priorityColor;
  final String salespersonName;
  final String salespersonProfileBgColor;
  final String agencyName;
  final String agencyProfileBgColor;

  TaskWithUsers({
    required this.taskId,
    required this.taskName,
    required this.dueDate,
    required this.statusName,
    required this.statusColor,
    required this.priorityName,
    required this.priorityColor,
    required this.salespersonName,
    required this.salespersonProfileBgColor,
    required this.agencyName,
    required this.agencyProfileBgColor,
  });

  factory TaskWithUsers.fromJson(Map<String, dynamic> json) => TaskWithUsers(
        taskId: json['task_id'],
        taskName: json['task_name'],
        dueDate: json['due_date'],
        statusName: json['status_name'],
        statusColor: json['status_color'],
        priorityName: json['priority_name'],
        priorityColor: json['priority_color'],
        salespersonName: json['salesperson_name'] ?? '',
        salespersonProfileBgColor: json['salesperson_profile_bg_color'] ?? '',
        agencyName: json['agency_name'] ?? '',
        agencyProfileBgColor: json['agency_profile_bg_color'] ?? '',
      );
}
