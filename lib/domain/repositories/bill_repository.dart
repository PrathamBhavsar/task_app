import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/bill.dart';

abstract class BillRepository {
  Future<Either<Failure, List<Bill>>> getAll();
}
