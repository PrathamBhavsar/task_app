// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_status_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateStatusPayload _$UpdateStatusPayloadFromJson(Map<String, dynamic> json) =>
    UpdateStatusPayload(
      userId: (json['user_id'] as num).toInt(),
      taskId: (json['task_id'] as num).toInt(),
      agencyId: (json['agency_id'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$UpdateStatusPayloadToJson(
  UpdateStatusPayload instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'task_id': instance.taskId,
  'agency_id': instance.agencyId,
  'status': instance.status,
};
