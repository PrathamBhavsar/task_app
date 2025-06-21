import 'package:json_annotation/json_annotation.dart';
import 'user.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  @JsonKey(name: 'message_id')
  final int? messageId;

  @JsonKey(name: 'task_id')
  final int taskId;

  final User user;

  final String message;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Message({
    required this.taskId,
    required this.user,
    required this.message,
    required this.createdAt,
    this.messageId,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
