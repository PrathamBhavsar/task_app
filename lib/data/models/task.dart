class Task {
  final String id;
  final String dealNo;
  final String name;
  final String createdAt;
  final String startDate;
  final String dueDate;
  final String priority;
  final String createdBy;
  final String? remarks;
  final String status;

  Task({
    required this.id,
    required this.dealNo,
    required this.name,
    required this.createdAt,
    required this.startDate,
    required this.dueDate,
    required this.priority,
    required this.createdBy,
    this.remarks,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        dealNo: json['deal_no'],
        name: json['name'],
        createdAt: json['created_at'],
        startDate: json['start_date'],
        dueDate: json['due_date'],
        priority: json['priority'],
        createdBy: json['created_by'],
        remarks: json['remarks'] ?? "",
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'deal_no': dealNo,
        'name': name,
        'created_at': createdAt,
        'start_date': startDate,
        'due_date': dueDate,
        'priority': priority,
        'created_by': createdBy,
        'remarks': remarks,
        'status': status,
      };
}
