import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/service_payload.dart';
import '../entities/service.dart';

abstract class ServiceRepository {
  Future<Either<Failure, List<Service>>> getAll(int taskId);
  Future<Either<Failure, List<Service>>> put(ServicePayload data);
}
