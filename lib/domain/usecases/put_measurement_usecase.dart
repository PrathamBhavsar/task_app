import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/measurement_payload.dart';
import '../entities/measurement.dart';
import '../repositories/measurement_repository.dart';

class PutMeasurementUseCase {
  final MeasurementRepository repository;
  PutMeasurementUseCase(this.repository);
  Future<Either<Failure, List<Measurement>>> call(MeasurementPayload data) {
    return repository.put(data);
  }
}