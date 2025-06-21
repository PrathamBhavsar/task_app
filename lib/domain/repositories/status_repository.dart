import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/status.dart';

abstract class StatusRepository {
  Future<Either<Failure, List<Status>>> getAll();
}
