// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'put_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PutMessageResponse _$PutMessageResponseFromJson(Map<String, dynamic> json) =>
    PutMessageResponse(
      message: Message.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PutMessageResponseToJson(PutMessageResponse instance) =>
    <String, dynamic>{'message': instance.message};
