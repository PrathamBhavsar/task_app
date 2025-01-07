import 'package:task_app/models/attachment.dart';
import 'package:task_app/models/client.dart';
import 'package:task_app/models/designer.dart';
import 'package:task_app/models/user.dart';

class TaskModel {
  final String? id;
  final String name;
  final String status;
  final String? dealNo;
  final String remarks;
  final DateTime dueDate;
  final String priority;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime startDate;
  final List<ClientModel>? taskClients;
  final List<UserModel>? taskAgencies;
  final List<DesignerModel>? taskDesigners;
  final List<AttachmentModel>? taskAttachments;
  final List<UserModel>? taskSalespersons;

  TaskModel({
    this.id,
    required this.name,
    required this.status,
    this.dealNo,
    required this.remarks,
    required this.dueDate,
    required this.priority,
    this.createdAt,
    this.createdBy,
    required this.startDate,
    this.taskClients,
    this.taskAgencies,
    this.taskDesigners,
    this.taskAttachments,
    this.taskSalespersons,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      dealNo: json['deal_no'],
      remarks: json['remarks'],
      dueDate: DateTime.parse(json['due_date']),
      priority: json['priority'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      createdBy: json['created_by'],
      startDate: DateTime.parse(json['start_date']),
      taskClients: (json['task_clients'] as List<dynamic>)
          .map((client) => ClientModel.fromJson(client))
          .toList(),
      taskAgencies: (json['task_agencies'] as List<dynamic>?)
          ?.map((agency) => UserModel.fromJson(agency))
          .toList(),
      taskDesigners: (json['task_designers'] as List<dynamic>)
          .map((designer) => DesignerModel.fromJson(designer))
          .toList(),
      taskAttachments: (json['task_attachments'] as List<dynamic>?)
          ?.map((attachment) => AttachmentModel.fromJson(attachment))
          .toList(),
      taskSalespersons: (json['task_salespersons'] as List<dynamic>)
          .map((salesperson) => UserModel.fromJson(salesperson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
      'deal_no': dealNo,
      'remarks': remarks,
      'due_date': dueDate.toIso8601String(),
      'priority': priority,
      'created_by': createdBy,
      'start_date': startDate.toIso8601String(),
    };
  }
}
