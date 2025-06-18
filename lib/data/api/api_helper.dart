import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../core/helpers/log_helper.dart';
import '../../domain/entities/client.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/user.dart';
import '../models/api/api_response.dart';
import '../models/payloads/auth_payload.dart';
import '../responses/get_clients_response.dart';
import '../responses/get_tasks_response.dart';
import '../responses/get_users_response.dart';
import 'api_constants.dart';
import 'api_handler.dart';
import 'api_service.dart';

class ApiHelper {
  final ApiService service;
  final ApiHandler handler;
  final LogHelper logger;

  ApiHelper({
    required this.service,
    required this.handler,
    required this.logger,
  });

  Future<Either<Failure, List<User>>> getAllUsers() async {
    final ApiResponse<GetUsersResponse> result = await handler
        .execute<GetUsersResponse>(
          () => service.get(ApiConstants.user.base),
          (json) => GetUsersResponse.fromJson(json as Map<String, dynamic>),
        );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.users);
    } else {
      return Left(Failure('Failed to fetch users'));
    }
  }

  Future<Either<Failure, List<Task>>> getAllTasks() async {
    final ApiResponse<GetTasksResponse> result = await handler
        .execute<GetTasksResponse>(
          () => service.get(ApiConstants.task.base),
          (json) => GetTasksResponse.fromJson(json as Map<String, dynamic>),
        );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.tasks);
    } else {
      return Left(Failure('Failed to fetch tasks'));
    }
  }

  Future<Either<Failure, List<Client>>> getAllClients() async {
    final ApiResponse<GetClientsResponse> result = await handler
        .execute<GetClientsResponse>(
          () => service.get(ApiConstants.client.base),
          (json) => GetClientsResponse.fromJson(json as Map<String, dynamic>),
        );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.clients);
    } else {
      return Left(Failure('Failed to fetch tasks'));
    }
  }

  Future<Either<Failure, User>> login(AuthPayload data) async {
    final ApiResponse<User> result = await handler
        .execute<User>(
          () => service.post(ApiConstants.user.login, data: data.toJson()),
          (json) => User.fromJson(json as Map<String, dynamic>),
        );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!);
    } else {
      return Left(Failure('Failed to login'));
    }
  }
}
