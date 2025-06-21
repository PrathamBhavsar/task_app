import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/timeline.dart';
import '../../domain/repositories/timeline_repository.dart';
import '../api/api_helper.dart';

class TimelineRepositoryImpl implements TimelineRepository {
  final ApiHelper api;

  TimelineRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<Timeline>>> getAll(int taskId) {
    return api.getTimelinesByTask(taskId);
  }
}
