import 'package:json_annotation/json_annotation.dart';

import '../../utils/converters/priority_converter.dart';
import '../../utils/converters/status_converter.dart';
import 'client.dart';
import 'designer.dart';
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
  final DateTime dueDate;

  @PriorityConverter()
  final Priority priority;

  @StatusConverter()
  final Status status;

  final Client client;
  final User? agency;
  final Designer designer;

  @JsonKey(name: 'assigned_users')
  final List<User> assignedUsers;

  final String? remarks;

  Task({
    required this.taskId,
    required this.dealNo,
    required this.client,
    required this.designer,
    required this.assignedUsers,
    required this.name,
    required this.status,
    required this.priority,
    required this.dueDate,
    required this.createdAt,
    this.agency,
    this.remarks,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}