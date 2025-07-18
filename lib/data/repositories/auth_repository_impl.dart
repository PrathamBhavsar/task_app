import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../api/api_helper.dart';
import '../models/payloads/auth_payload.dart';
import '../responses/auth/login_response.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiHelper api;
  AuthRepositoryImpl(this.api);
  @override
  Future<Either<Failure, LoginResponse>> login(AuthPayload data) async {
    return api.login(data);
  }
}
