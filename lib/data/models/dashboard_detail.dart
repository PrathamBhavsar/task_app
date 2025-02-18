class DashboardStatus {
  final String statusName;
  final int taskCount;

  DashboardStatus({
    required this.statusName,
    required this.taskCount,
  });

  factory DashboardStatus.fromJson(Map<String, dynamic> json) =>
      DashboardStatus(
        statusName: json['status_name'],
        taskCount: json['task_count'],
      );

  Map<String, dynamic> toJson() => {
        'status_name': statusName,
        'task_count': taskCount,
      };

  static List<DashboardStatus> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((json) => DashboardStatus.fromJson(json)).toList();
}
