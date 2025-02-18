class DashboardStatus {
  final String statusName;
  final int taskCount;
  final String? category;

  DashboardStatus({
    required this.statusName,
    required this.taskCount,
    this.category,
  });

  factory DashboardStatus.fromJson(Map<String, dynamic> json) =>
      DashboardStatus(
        statusName: json['status_name'],
        taskCount: json['task_count'],
        category: _extractCategory(json['status_name']),
      );

  Map<String, dynamic> toJson() => {
        'status_name': statusName,
        'task_count': taskCount,
        'category': category,
      };

  static List<DashboardStatus> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((json) => DashboardStatus.fromJson(json)).toList();

  static String _extractCategory(String statusName) {
    final parts = statusName.split(':');
    return parts.isNotEmpty ? parts[0].trim() : '';
  }
}
