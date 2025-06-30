import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/quote.dart';

abstract class QuoteRepository {
  Future<Either<Failure, Quote>> getAll(int taskId);
}
