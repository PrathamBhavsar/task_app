import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/task.dart';
import '../api/api_helper.dart';

class TaskRepository {
  final ApiHelper _api;

  TaskRepository(this._api);

  Future<Either<Failure, List<Task>>> getAll() async {
    return await _api.getAllTasks();
  }
}
