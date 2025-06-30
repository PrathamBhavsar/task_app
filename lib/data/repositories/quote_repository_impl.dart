import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';
import '../api/api_helper.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final ApiHelper api;
  QuoteRepositoryImpl(this.api);
  @override
  Future<Either<Failure, Quote>> getAll(int taskId) {
    return api.getAllQuotes(taskId);
  }
}
