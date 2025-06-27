import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/bill.dart';
import '../entities/service_master.dart';

abstract class ServiceMasterRepository {
  Future<Either<Failure, List<ServiceMaster>>> getAll();
}
