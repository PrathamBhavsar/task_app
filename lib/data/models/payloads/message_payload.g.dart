// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagePayload _$MessagePayloadFromJson(Map<String, dynamic> json) =>
    MessagePayload(
      userId: (json['user_id'] as num).toInt(),
      taskId: (json['task_id'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$MessagePayloadToJson(MessagePayload instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'task_id': instance.taskId,
      'message': instance.message,
    };
