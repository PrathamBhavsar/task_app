import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';
import '../../core/helpers/log_helper.dart';
import '../../domain/entities/bill.dart';
import '../../domain/entities/client.dart';
import '../../domain/entities/designer.dart';
import '../../domain/entities/measurement.dart';
import '../../domain/entities/message.dart';
import '../../domain/entities/quote.dart';
import '../../domain/entities/service.dart';
import '../../domain/entities/service_master.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/timeline.dart';
import '../../domain/entities/user.dart';
import '../models/api/api_response.dart';
import '../models/payloads/auth_payload.dart';
import '../models/payloads/client_payload.dart';
import '../models/payloads/measurement_payload.dart';
import '../models/payloads/message_payload.dart';
import '../models/payloads/service_payload.dart';
import '../models/payloads/task_payload.dart';
import '../models/payloads/update_status_payload.dart';
import '../responses/client/put_client_response.dart';
import '../responses/get_bills_response.dart';
import '../responses/client/get_clients_response.dart';
import '../responses/get_designers_response.dart';
import '../responses/get_messages_response.dart';
import '../responses/get_quote_response.dart';
import '../responses/task/get_measurement_response.dart';
import '../responses/task/get_service_masters_response.dart';
import '../responses/task/get_service_response.dart';
import '../responses/task/get_tasks_response.dart';
import '../responses/get_timelines_response.dart';
import '../responses/get_users_response.dart';
import '../responses/put_message_response.dart';
import '../responses/task/put_task_response.dart';
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
      return Left(Failure(result.error!.message));
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
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, Task>> putTask(TaskPayload data) async {
    final ApiResponse result = await handler.execute<PutTaskResponse>(
      () => service.post(ApiConstants.task.base, data: data.toJson()),
      (json) => PutTaskResponse.fromJson(json as Map<String, dynamic>),
    );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.task);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, Task>> updateTask(TaskPayload data) async {
    final ApiResponse result = await handler.execute<PutTaskResponse>(
      () => service.put(
        ApiConstants.task.update,
        data: data.toJson(),
        params: {"id": data.taskId},
      ),
      (json) => PutTaskResponse.fromJson(json as Map<String, dynamic>),
    );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.task);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, Task>> updateTaskStatus(
    UpdateStatusPayload data,
  ) async {
    final ApiResponse result = await handler.execute<Task>(
      () => service.put(
        ApiConstants.task.update,
        data: data.toJson(),
        params: {"id": data.taskId, "status": data.status},
      ),
      (json) => Task.fromJson(json as Map<String, dynamic>),
    );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!);
    } else {
      return Left(Failure(result.error!.message));
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
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, Client>> putClient(ClientPayload data) async {
    final ApiResponse result = await handler.execute<PutClientResponse>(
      () => service.post(ApiConstants.client.base, data: data.toJson()),
      (json) => PutClientResponse.fromJson(json as Map<String, dynamic>),
    );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.client);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, List<Designer>>> getAllDesigners() async {
    final ApiResponse<GetDesignersResponse> result = await handler
        .execute<GetDesignersResponse>(
          () => service.get(ApiConstants.designer.base),
          (json) => GetDesignersResponse.fromJson(json as Map<String, dynamic>),
        );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.designers);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, List<Bill>>> getAllBills() async {
    final ApiResponse<GetBillsResponse> result = await handler
        .execute<GetBillsResponse>(
          () => service.get(ApiConstants.bill.base),
          (json) => GetBillsResponse.fromJson(json as Map<String, dynamic>),
        );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.bills);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, Quote>> getAllQuotes(int taskId) async {
    final ApiResponse<GetQuoteResponse> result = await handler
        .execute<GetQuoteResponse>(
          () => service.get(ApiConstants.quote.base, queryParameters: {"task_id" : taskId}),
          (json) => GetQuoteResponse.fromJson(json as Map<String, dynamic>),
        );
    if (result.isSuccess && result.data != null) {
      return Right(result.data!.quote);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, List<Timeline>>> getTimelinesByTask(int taskId) async {
    final ApiResponse result = await handler.execute<GetTimelinesResponse>(
      () => service.get(
        ApiConstants.timeline.base,
        queryParameters: {"task_id": taskId},
      ),
      (json) => GetTimelinesResponse.fromJson(json as Map<String, dynamic>),
    );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.timelines);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, Message>> putMessage(MessagePayload data) async {
    final ApiResponse result = await handler.execute<PutMessageResponse>(
      () => service.post(ApiConstants.message.base, data: data.toJson()),
      (json) => PutMessageResponse.fromJson(json as Map<String, dynamic>),
    );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.status);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, List<Message>>> getMessagesByTask(int taskId) async {
    final ApiResponse result = await handler.execute<GetMessagesResponse>(
      () => service.get(
        ApiConstants.message.base,
        queryParameters: {"task_id": taskId},
      ),
      (json) => GetMessagesResponse.fromJson(json as Map<String, dynamic>),
    );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.taskMessages);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, List<Measurement>>> getMeasurementsByTaskId(
    int taskId,
  ) async {
    final ApiResponse result = await handler.execute<GetMeasurementResponse>(
      () => service.get(
        ApiConstants.measurement.base,
        queryParameters: {"task_id": taskId},
      ),
      (json) => GetMeasurementResponse.fromJson(json as Map<String, dynamic>),
    );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.measurements);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, List<Measurement>>> putMeasurement(
    MeasurementPayload data,
  ) async {
    final ApiResponse result = await handler.execute<GetMeasurementResponse>(
      () => service.post(
        ApiConstants.measurement.base,
        data: data.measurements.map((m) => m.toJson()).toList(),
      ),
      (json) => GetMeasurementResponse.fromJson(json as Map<String, dynamic>),
    );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.measurements);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, List<ServiceMaster>>> getAllServiceMasters() async {
    final ApiResponse<GetServiceMastersResponse> result = await handler
        .execute<GetServiceMastersResponse>(
          () => service.get(ApiConstants.serviceMaster.base),
          (json) => GetServiceMastersResponse.fromJson(json as Map<String, dynamic>),
    );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.serviceMasters);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, List<Service>>> getServicesByTaskId(
      int taskId,
      ) async {
    final ApiResponse result = await handler.execute<GetServiceResponse>(
          () => service.get(
        ApiConstants.service.base,
        queryParameters: {"task_id": taskId},
      ),
          (json) => GetServiceResponse.fromJson(json as Map<String, dynamic>),
    );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.services);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, List<Service>>> putService(
      ServicePayload data,
      ) async {
    final ApiResponse result = await handler.execute<GetServiceResponse>(
          () => service.post(
        ApiConstants.service.base,
        data: data.services.map((m) => m.toJson()).toList(),
      ),
          (json) => GetServiceResponse.fromJson(json as Map<String, dynamic>),
    );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!.services);
    } else {
      return Left(Failure(result.error!.message));
    }
  }

  Future<Either<Failure, User>> login(AuthPayload data) async {
    final ApiResponse<User> result = await handler.execute<User>(
      () => service.post(ApiConstants.user.login, data: data.toJson()),
      (json) => User.fromJson(json as Map<String, dynamic>),
    );

    if (result.isSuccess && result.data != null) {
      return Right(result.data!);
    } else {
      return Left(Failure(result.error!.message));
    }
  }
}
