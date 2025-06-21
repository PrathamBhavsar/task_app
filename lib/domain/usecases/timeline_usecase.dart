import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/timeline.dart';
import '../repositories/timeline_repository.dart';

class GetAllTimelinesUseCase {
  final TimelineRepository repository;
  GetAllTimelinesUseCase(this.repository);
  Future<Either<Failure, List<Timeline>>> call(int taskId) {
    return repository.getAll(taskId);
  }
}