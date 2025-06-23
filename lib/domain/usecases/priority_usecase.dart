import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/priority.dart';
import '../repositories/priority_repository.dart';

class GetAllPrioritiesUseCase {
  final PriorityRepository repository;
  GetAllPrioritiesUseCase(this.repository);
  Future<Either<Failure, List<Priority>>> call() {
    return repository.getAll();
  }
}