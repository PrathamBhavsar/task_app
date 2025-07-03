import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/quote_measurement.dart';

abstract class QuoteMeasurementRepository {
  Future<Either<Failure, List<QuoteMeasurement>>> getAll(int taskId);
}
