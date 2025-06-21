// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  taskId: (json['task_id'] as num).toInt(),
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  message: json['message'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  messageId: (json['message_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'message_id': instance.messageId,
  'task_id': instance.taskId,
  'user': instance.user,
  'message': instance.message,
  'created_at': instance.createdAt.toIso8601String(),
};
