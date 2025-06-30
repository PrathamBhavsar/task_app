import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/quote.dart';
import '../repositories/quote_repository.dart';

class GetAllQuotesUseCase {
  final QuoteRepository repository;
  GetAllQuotesUseCase(this.repository);
  Future<Either<Failure, Quote>> call(int taskId) {
    return repository.getAll(taskId);
  }
}