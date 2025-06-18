import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/auth_payload.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<Either<Failure, User>> call(AuthPayload data) {
    return repository.login(data);
  }
}
