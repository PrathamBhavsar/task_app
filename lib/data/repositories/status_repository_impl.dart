import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/status.dart';
import '../../domain/repositories/status_repository.dart';
import '../api/api_helper.dart';

class StatusRepositoryImpl implements StatusRepository {
  final ApiHelper api;
  StatusRepositoryImpl(this.api);
  @override
  Future<Either<Failure, List<Status>>> getAll() {
    return api.getAllStatuses();
  }
}
