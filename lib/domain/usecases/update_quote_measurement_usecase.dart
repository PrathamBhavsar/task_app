import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/quote.dart';
import '../entities/update_quote_measurement.dart';
import '../repositories/quote_repository.dart';

class UpdateQuoteMeasurementUseCase {
  final QuoteRepository repository;
  UpdateQuoteMeasurementUseCase(this.repository);
  Future<Either<Failure, Quote>> call(List<UpdateQuoteMeasurement> data) {
    return repository.updateMeasurements(data);
  }
}