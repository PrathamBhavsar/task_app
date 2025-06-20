import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../api/api_helper.dart';

class TaskRepositoryImpl implements TaskRepository {
  final ApiHelper api;

  TaskRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<Task>>> getAll() {
    return api.getAllTasks();
  }
}
