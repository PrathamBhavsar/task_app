import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/client.dart';
import '../repositories/client_repository.dart';

class GetAllClientsUseCase {
  final ClientRepository repository;
  GetAllClientsUseCase(this.repository);
  Future<Either<Failure, List<Client>>> call() {
    return repository.getAll();
  }
}