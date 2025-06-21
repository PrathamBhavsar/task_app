abstract class MessageEvent {}
class FetchMessagesRequested extends MessageEvent {
  final int taskId;

  FetchMessagesRequested(this.taskId);
}
