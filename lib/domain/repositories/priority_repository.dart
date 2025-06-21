import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/priority.dart';
import '../entities/status.dart';

abstract class PriorityRepository {
  Future<Either<Failure, List<Priority>>> getAll();
}
