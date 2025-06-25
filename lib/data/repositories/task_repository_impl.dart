import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../api/api_helper.dart';
import '../models/payloads/task_payload.dart';
import '../models/payloads/update_status_payload.dart';

class TaskRepositoryImpl implements TaskRepository {
  final ApiHelper api;

  TaskRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<Task>>> getAll() {
    return api.getAllTasks();
  }

  @override
  Future<Either<Failure, Task>> put(TaskPayload data) {
    return api.putTask(data);
  }

  @override
  Future<Either<Failure, Task>> updateStatus(UpdateStatusPayload data) {
    return api.updateTaskStatus(data);
  }
}
