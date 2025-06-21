import '../../../core/error/failure.dart';
import '../../../domain/entities/message.dart';

abstract class MessageState {}
class MessageInitial extends MessageState {}
class MessageLoadInProgress extends MessageState {}
class MessageLoadSuccess extends MessageState {
  final List<Message> messages;
  MessageLoadSuccess(this.messages);
}
class MessageLoadFailure extends MessageState {
  final Failure error;
  MessageLoadFailure(this.error);
}
