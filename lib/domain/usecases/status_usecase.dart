import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/status.dart';
import '../repositories/status_repository.dart';

class GetAllStatusesUseCase {
  final StatusRepository repository;
  GetAllStatusesUseCase(this.repository);
  Future<Either<Failure, List<Status>>> call() {
    return repository.getAll();
  }
}