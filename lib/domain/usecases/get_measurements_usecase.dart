import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/measurement.dart';
import '../repositories/measurement_repository.dart';

class GetAllMeasurementsUseCase {
  final MeasurementRepository repository;
  GetAllMeasurementsUseCase(this.repository);
  Future<Either<Failure, List<Measurement>>> call(int taskId) {
    return repository.getAll(taskId);
  }
}