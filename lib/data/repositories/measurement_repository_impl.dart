import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/measurement.dart';
import '../../domain/repositories/measurement_repository.dart';
import '../api/api_helper.dart';
import '../models/payloads/measurement_payload.dart';

class MeasurementRepositoryImpl implements MeasurementRepository {
  final ApiHelper api;

  MeasurementRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<Measurement>>> getAll(int taskId) {
    return api.getMeasurementsByTaskId(taskId);
  }

  @override
  Future<Either<Failure, List<Measurement>>> put(MeasurementPayload data) {
    return api.putMeasurement(data);
  }
}
