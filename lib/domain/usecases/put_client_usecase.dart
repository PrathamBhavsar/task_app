import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/client_payload.dart';
import '../entities/client.dart';
import '../repositories/client_repository.dart';

class PutClientUseCase {
  final ClientRepository repository;

  PutClientUseCase(this.repository);

  Future<Either<Failure, Client>> call(ClientPayload data) {
    return repository.put(data);
  }
}
