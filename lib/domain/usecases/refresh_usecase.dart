import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/auth_payload.dart';
import '../../data/models/payloads/refresh_payload.dart';
import '../../data/responses/auth/login_response.dart';
import '../../data/responses/auth/refresh_response.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RefreshUseCase {
  final AuthRepository repository;

  RefreshUseCase(this.repository);

  Future<Either<Failure, RefreshResponse>> call(RefreshPayload data) {
    return repository.refresh(data);
  }
}
