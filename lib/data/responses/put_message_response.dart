import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/message.dart';
part 'put_message_response.g.dart';

@JsonSerializable()
class PutMessageResponse {
  @JsonKey(name: 'message')
  final Message message;

  PutMessageResponse({required this.message});

  factory PutMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$PutMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PutMessageResponseToJson(this);
}
