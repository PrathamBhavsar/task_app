import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/user.dart';
import '../api/api_helper.dart';

class UserRepository {
  final ApiHelper _api;

  UserRepository(this._api);

  Future<Either<Failure, List<User>>> getAll() async {
    return await _api.getAllUsers();
  }
}
