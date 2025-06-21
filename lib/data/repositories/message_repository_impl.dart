import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../api/api_helper.dart';
import '../models/payloads/message_payload.dart';

class MessageRepositoryImpl implements MessageRepository {
  final ApiHelper api;

  MessageRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<Message>>> getAll(int taskId) {
    return api.getMessagesByTask(taskId);
  }

  @override
  Future<Either<Failure, Message>> put(MessagePayload data) {
    return api.putMessage(data);
  }
}
