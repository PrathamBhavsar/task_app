import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../data/models/payloads/auth_payload.dart';
import '../entities/client.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(AuthPayload data);
}
