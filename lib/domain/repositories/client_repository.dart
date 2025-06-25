import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/client_payload.dart';
import '../entities/client.dart';

abstract class ClientRepository {
  Future<Either<Failure, List<Client>>> getAll();
  Future<Either<Failure, Client>> put(ClientPayload data);
}
