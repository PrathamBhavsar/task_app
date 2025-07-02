import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/quote.dart';
import '../../domain/entities/update_quote_measurement.dart';
import '../../domain/repositories/quote_repository.dart';
import '../api/api_helper.dart';
import '../models/payloads/update_quote_payload.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final ApiHelper api;

  QuoteRepositoryImpl(this.api);

  @override
  Future<Either<Failure, Quote>> getAll(int taskId) {
    return api.getAllQuotes(taskId);
  }

  @override
  Future<Either<Failure, Quote>> update(UpdateQuotePayload data) {
    return api.updateQuote(data);
  }

  @override
  Future<Either<Failure, Quote>> updateMeasurements(List<UpdateQuoteMeasurement> data) {
    return api.updateQuoteMeasurements(data);
  }
}
