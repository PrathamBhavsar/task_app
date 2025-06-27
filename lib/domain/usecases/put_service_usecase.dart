import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/service_payload.dart';
import '../entities/service.dart';
import '../repositories/service_repository.dart';

class PutServiceUseCase {
  final ServiceRepository repository;
  PutServiceUseCase(this.repository);
  Future<Either<Failure, List<Service>>> call(ServicePayload data) {
    return repository.put(data);
  }
}