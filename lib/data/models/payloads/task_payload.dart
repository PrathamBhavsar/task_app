import 'package:json_annotation/json_annotation.dart';

part 'task_payload.g.dart';

@JsonSerializable()
class TaskPayload {
  @JsonKey(name: "deal_no")
  final String dealNo;
  final String name;

  @JsonKey(name: "start_date")
  final String startDate;

  @JsonKey(name: "due_date")
  final String dueDate;

  final String priority;

  final String? remarks;

  final String status;

  @JsonKey(name: "created_by")
  final int createdById;

  @JsonKey(name: "client_id")
  final int clientId;

  @JsonKey(name: "designer_id")
  final int designerId;

  @JsonKey(name: "agency_id", includeIfNull: false)
  final int? agencyId;

  @JsonKey(name: "assigned_users")
  final List<int> assignedUsers;

  const TaskPayload({
    required this.assignedUsers,
    required this.dealNo,
    required this.name,
    required this.startDate,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.createdById,
    required this.clientId,
    required this.designerId,
    this.remarks,
    this.agencyId,
  });

  Map<String, dynamic> toJson() => _$TaskPayloadToJson(this);
}
