import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/measurement_payload.dart';
import '../entities/measurement.dart';

abstract class MeasurementRepository {
  Future<Either<Failure, List<Measurement>>> getAll(int taskId);
  Future<Either<Failure, List<Measurement>>> put(MeasurementPayload data);
}
