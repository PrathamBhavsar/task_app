// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_messages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMessagesResponse _$GetMessagesResponseFromJson(Map<String, dynamic> json) =>
    GetMessagesResponse(
      taskMessages:
          (json['messages'] as List<dynamic>)
              .map((e) => Message.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$GetMessagesResponseToJson(
  GetMessagesResponse instance,
) => <String, dynamic>{'messages': instance.taskMessages};
