import 'client.dart';
import 'designer.dart';
import 'priority.dart';
import 'status.dart';
import 'user.dart';

class TaskWithDetails {
  final String id;
  final String dealNo;
  final String name;
  final String createdAt;
  final String startDate;
  final String dueDate;
  final String? remarks;

  final Status status;
  final Priority priority;
  final User salesperson;
  final User agency;
  final Client client;
  final Designer designer;

  TaskWithDetails({
    required this.id,
    required this.dealNo,
    required this.name,
    required this.createdAt,
    required this.startDate,
    required this.dueDate,
    this.remarks,
    required this.status,
    required this.priority,
    required this.salesperson,
    required this.agency,
    required this.client,
    required this.designer,
  });

  factory TaskWithDetails.fromJson(Map<String, dynamic> json) =>
      TaskWithDetails(
        id: json['id'],
        dealNo: json['deal_no'],
        name: json['name'],
        createdAt: json['created_at'],
        startDate: json['start_date'],
        dueDate: json['due_date'],
        remarks: json['remarks'] ?? "",
        status: Status.fromJson(json['status']),
        priority: Priority.fromJson(json['priority']),
        designer: Designer.fromJson(json['designer']),
        salesperson: User.fromJson(json['salesperson']),
        agency: User.fromJson(json['agency']),
        client: Client.fromJson(json['client']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'deal_no': dealNo,
        'name': name,
        'created_at': createdAt,
        'start_date': startDate,
        'due_date': dueDate,
        'remarks': remarks,
        'status': status.toJson(),
        'priority': priority.toJson(),
        'salesperson': salesperson.toJson(),
        'agency': agency.toJson(),
        'client': client.toJson(),
        'designer': designer.toJson(),
      };
}
