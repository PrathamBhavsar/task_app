import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/timeline.dart';

abstract class TimelineRepository {
  Future<Either<Failure, List<Timeline>>> getAll(int taskId);
}
