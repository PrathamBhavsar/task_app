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
  final String salespersonId;
  final String agencyId;
  final String designerId;
  final String clientId;

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
    required this.salespersonId,
    required this.agencyId,
    required this.designerId,
    required this.clientId,
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
        salespersonId: json['salesperson_id'],
        agencyId: json['agency_id'],
        designerId: json['designer_id'],
        clientId: json['client_id'],
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
        'salesperson_id': salespersonId,
        'agency_id': agencyId,
        'designer_id': designerId,
        'client_id': clientId,
      };
}
