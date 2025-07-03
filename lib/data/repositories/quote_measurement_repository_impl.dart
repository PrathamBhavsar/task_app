import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/quote_measurement.dart';
import '../../domain/repositories/quote_measurement_repository.dart';
import '../api/api_helper.dart';

class QuoteMeasurementRepositoryImpl implements QuoteMeasurementRepository {
  final ApiHelper api;

  QuoteMeasurementRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<QuoteMeasurement>>> getAll(int taskId) {
    return api.getAllQuoteMeasurementsByTaskId(taskId);
  }

}
