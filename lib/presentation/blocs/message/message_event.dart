import '../../../data/models/payloads/message_payload.dart';

abstract class MessageEvent {}

class FetchMessagesRequested extends MessageEvent {
  final int taskId;

  FetchMessagesRequested(this.taskId);
}

class PutMessageRequested extends MessageEvent {
  final MessagePayload data;

  PutMessageRequested(this.data);
}
