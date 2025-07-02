import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/update_quote_payload.dart';
import '../entities/quote.dart';
import '../repositories/quote_repository.dart';

class UpdateQuoteUseCase {
  final QuoteRepository repository;
  UpdateQuoteUseCase(this.repository);
  Future<Either<Failure, Quote>> call(UpdateQuotePayload data) {
    return repository.update(data);
  }
}