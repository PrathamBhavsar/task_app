import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/task_payload.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class PutTaskUseCase {
  final TaskRepository repository;
  PutTaskUseCase(this.repository);
  Future<Either<Failure, Task>> call(TaskPayload data) {
    return repository.put(data);
  }
}