import 'package:either_dart/either.dart';

import '../../domain/entities/user.dart';
import '../api/api_helper.dart';
import '../models/api/api_error.dart';

class UserRepository {
  final ApiHelper _api;

  UserRepository(this._api);

  Future<Either<ApiError, List<User>>> getAll() async {
    return await _api.getAllUsers();
  }
}
