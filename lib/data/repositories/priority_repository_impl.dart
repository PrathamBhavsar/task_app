import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/priority.dart';
import '../../domain/repositories/priority_repository.dart';
import '../api/api_helper.dart';

class PriorityRepositoryImpl implements PriorityRepository {
  final ApiHelper api;
  PriorityRepositoryImpl(this.api);
  @override
  Future<Either<Failure, List<Priority>>> getAll() {
    return api.getAllPriorities();
  }
}
