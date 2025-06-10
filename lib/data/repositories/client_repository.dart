import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/client.dart';
import '../../domain/entities/task.dart';
import '../api/api_helper.dart';

class ClientRepository {
  final ApiHelper _api;

  ClientRepository(this._api);

  Future<Either<Failure, List<Client>>> getAll() async {
    return await _api.getAllClients();
  }
}
