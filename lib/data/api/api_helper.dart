import 'package:either_dart/either.dart';

import '../../core/services/log_service.dart';
import '../../domain/entities/user.dart';
import '../models/api/api_error.dart';
import '../models/api/api_response.dart';
import '../responses/get_users_response.dart';
import 'api_constants.dart';
import 'api_handler.dart';
import 'api_service.dart';

class ApiHelper {
  final ApiService service;
  final ApiHandler handler;
  final LogService logger;

  ApiHelper({
    required this.service,
    required this.handler,
    required this.logger,
  });

  Future<Either<ApiError, List<User>>> getAllUsers() async {
    final ApiResponse<GetUsersResponse> result = await handler
        .execute<GetUsersResponse>(
          () => service.get(ApiConstants.user.base),
          (json) => GetUsersResponse.fromJson(json as Map<String, dynamic>),
        );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.users);
    } else {
      return Left(result.error ?? ApiError.unknownError());
    }
  }
}
