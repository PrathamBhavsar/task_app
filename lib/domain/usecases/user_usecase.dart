import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/repositories/user_repository.dart';
import '../entities/client.dart';
import '../entities/user.dart';
import '../repositories/client_repository.dart';

class GetAllUsersUseCase {
  final UserRepository repository;
  GetAllUsersUseCase(this.repository);
  Future<Either<Failure, List<User>>> call() {
    return repository.getAll();
  }
}