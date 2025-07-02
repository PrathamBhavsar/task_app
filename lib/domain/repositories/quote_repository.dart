import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/update_quote_payload.dart';
import '../entities/quote.dart';
import '../entities/update_quote_measurement.dart';

abstract class QuoteRepository {
  Future<Either<Failure, Quote>> getAll(int taskId);
  Future<Either<Failure, Quote>> update(UpdateQuotePayload data);
  Future<Either<Failure, Quote>> updateMeasurements(List<UpdateQuoteMeasurement> data);
}
