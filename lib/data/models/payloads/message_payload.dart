import 'package:json_annotation/json_annotation.dart';

part 'message_payload.g.dart';

@JsonSerializable()
class MessagePayload {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'task_id')
  final int taskId;
  final String message;

  const MessagePayload({
    required this.userId,
    required this.taskId,
    required this.message,
  });

  Map<String, dynamic> toJson() => _$MessagePayloadToJson(this);
}
