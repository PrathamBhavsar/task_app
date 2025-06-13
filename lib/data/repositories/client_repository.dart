import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/client.dart';
import '../../domain/repositories/client_repo.dart';
import '../api/api_helper.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ApiHelper api;
  ClientRepositoryImpl(this.api);
  @override
  Future<Either<Failure, List<Client>>> getAll() {
    return api.getAllClients();
  }
}
