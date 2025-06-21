import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/message.dart';
part 'get_messages_response.g.dart';

@JsonSerializable()
class GetMessagesResponse {
  @JsonKey(name: 'messages')
  final List<Message> taskMessages;

  GetMessagesResponse({required this.taskMessages});

  factory GetMessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMessagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMessagesResponseToJson(this);
}
