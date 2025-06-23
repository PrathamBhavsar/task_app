import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/repositories/user_repository.dart';
import '../entities/user.dart';

class GetAllUsersUseCase {
  final UserRepository repository;
  GetAllUsersUseCase(this.repository);
  Future<Either<Failure, List<User>>> call() {
    return repository.getAll();
  }
}