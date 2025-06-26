import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/task_payload.dart';
import '../../data/models/payloads/update_status_payload.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;
  UpdateTaskUseCase(this.repository);
  Future<Either<Failure, Task>> call(TaskPayload data) {
    return repository.updateTask(data);
  }
}