import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/task_payload.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<Task>>> getAll();
  Future<Either<Failure, Task>> put(TaskPayload data);
}