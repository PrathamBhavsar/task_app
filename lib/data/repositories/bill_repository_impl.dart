import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/bill.dart';
import '../../domain/repositories/bill_repository.dart';
import '../api/api_helper.dart';

class BillRepositoryImpl implements BillRepository {
  final ApiHelper api;
  BillRepositoryImpl(this.api);
  @override
  Future<Either<Failure, List<Bill>>> getAll() {
    return api.getAllBills();
  }
}
