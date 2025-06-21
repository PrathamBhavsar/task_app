import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/message_payload.dart';
import '../entities/message.dart';
import '../repositories/message_repository.dart';

class PutMessageUseCase {
  final MessageRepository repository;
  PutMessageUseCase(this.repository);
  Future<Either<Failure, Message>> call(MessagePayload data) {
    return repository.put(data);
  }
}