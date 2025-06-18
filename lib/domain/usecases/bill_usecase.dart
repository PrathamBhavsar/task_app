import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/bill.dart';
import '../repositories/bill_repository.dart';

class GetAllBillsUseCase {
  final BillRepository repository;
  GetAllBillsUseCase(this.repository);
  Future<Either<Failure, List<Bill>>> call() {
    return repository.getAll();
  }
}