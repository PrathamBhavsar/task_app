import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/service.dart';
import '../../domain/repositories/service_repository.dart';
import '../api/api_helper.dart';
import '../models/payloads/service_payload.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ApiHelper api;

  ServiceRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<Service>>> getAll(int taskId) {
    return api.getServicesByTaskId(taskId);
  }

  @override
  Future<Either<Failure, List<Service>>> put(ServicePayload data) {
    return api.putService(data);
  }
}
