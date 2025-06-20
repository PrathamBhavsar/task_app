import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<Task>>> getAll();
}
