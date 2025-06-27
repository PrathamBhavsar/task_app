import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/service.dart';
import '../repositories/service_repository.dart';

class GetAllServicesUseCase {
  final ServiceRepository repository;
  GetAllServicesUseCase(this.repository);
  Future<Either<Failure, List<Service>>> call(int taskId) {
    return repository.getAll(taskId);
  }
}