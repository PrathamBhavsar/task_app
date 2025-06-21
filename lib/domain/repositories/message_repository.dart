import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/message.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<Message>>> getAll(int taskId);
}
