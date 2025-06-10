import 'package:json_annotation/json_annotation.dart';

import 'client.dart';
import 'priority.dart';
import 'status.dart';
import 'user.dart';

part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task {
  @JsonKey(name: 'task_id')
  final int? taskId;

  @JsonKey(name: 'deal_no')
  final String dealNo;

  final String name;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'due_date')
  final String dueDate;

  final Priority priority;
  final Status status;

  final Client client;
  final User? agency;
  final User designer;

  @JsonKey(name: 'assigned_users')
  final List<User> assignedUsers;

  final String phone;

  Task({
    required this.taskId,
    required this.dealNo,
    required this.client,
    required this.designer,
    required this.assignedUsers,
    required this.name,
    required this.phone,
    required this.status,
    required this.priority,
    required this.dueDate,
    required this.createdAt,
    this.agency,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
