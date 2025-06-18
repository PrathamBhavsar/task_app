import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../api/api_helper.dart';
import '../models/payloads/auth_payload.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiHelper api;
  AuthRepositoryImpl(this.api);
  @override
  Future<Either<Failure, User>> login(AuthPayload data) async {
    return api.login(data);
  }
}
