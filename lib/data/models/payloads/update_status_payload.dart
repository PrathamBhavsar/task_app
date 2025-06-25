import 'package:json_annotation/json_annotation.dart';

part 'update_status_payload.g.dart';

@JsonSerializable()
class UpdateStatusPayload {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'task_id')
  final int taskId;

  @JsonKey(name: 'agency_id')
  final int agencyId;
  final String status;

  const UpdateStatusPayload({
    required this.userId,
    required this.taskId,
    required this.agencyId,
    required this.status,
  });

  Map<String, dynamic> toJson() => _$UpdateStatusPayloadToJson(this);
}
