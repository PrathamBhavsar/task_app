import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../entities/client.dart';

abstract class ClientRepository {
  Future<Either<Failure, List<Client>>> getAll();
}
