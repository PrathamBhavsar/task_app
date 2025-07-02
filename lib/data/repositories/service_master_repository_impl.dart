import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/service_master.dart';
import '../../domain/repositories/service_master_repository.dart';
import '../api/api_helper.dart';

class ServiceMasterRepositoryImpl implements ServiceMasterRepository {
  final ApiHelper api;
  ServiceMasterRepositoryImpl(this.api);
  @override
  Future<Either<Failure, List<ServiceMaster>>> getAll() {
    return api.getAllServiceMasters();
  }
}
