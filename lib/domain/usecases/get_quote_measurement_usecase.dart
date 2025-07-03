import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/quote_measurement.dart';
import '../repositories/quote_measurement_repository.dart';

class GetAllQuoteMeasurementsUseCase {
  final QuoteMeasurementRepository repository;

  GetAllQuoteMeasurementsUseCase(this.repository);

  Future<Either<Failure, List<QuoteMeasurement>>> call(int taskId) {
    return repository.getAll(taskId);
  }
}
