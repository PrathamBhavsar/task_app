import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/message.dart';
import '../repositories/message_repository.dart';

class GetAllMessagesUseCase {
  final MessageRepository repository;
  GetAllMessagesUseCase(this.repository);
  Future<Either<Failure, List<Message>>> call(int taskId) {
    return repository.getAll(taskId);
  }
}