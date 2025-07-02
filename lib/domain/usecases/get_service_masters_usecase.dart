import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/service_master.dart';
import '../repositories/service_master_repository.dart';

class GetAllServiceMastersUseCase {
  final ServiceMasterRepository repository;

  GetAllServiceMastersUseCase(this.repository);

  Future<Either<Failure, List<ServiceMaster>>> call() {
    return repository.getAll();
  }
}
