import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetAllTasksUseCase {
  final TaskRepository repository;
  GetAllTasksUseCase(this.repository);
  Future<Either<Failure, List<Task>>> call() {
    return repository.getAll();
  }
}