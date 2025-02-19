import '../../../data/models/api_response.dart';
import '../../core/dto/get_tasks_dto.dart';
import '../../data/models/dashboard_detail.dart';
import '../../data/models/task.dart';
import '../../data/models/user.dart';
import '../../data/repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<ApiResponse<List<Task>>> execute(GetTasksDTO requestDTO) async {
    final response = await repository.fetchTasks(requestDTO);

    if (response.success && response.data != null) {
      List<Task> users = List<Task>.from(response.data!);

      return ApiResponse(
          success: true, statusCode: 200, message: "Success", data: users);
    }

    return ApiResponse(
      success: false,
      statusCode: response.statusCode,
      message: response.message,
      data: [],
    );
  }

  Future<ApiResponse<List<DashboardStatus>>> getDashboardDetails() async {
    final response = await repository.dashBoardDetails();

    if (response.success && response.data != null) {
      List<DashboardStatus> dashboardDetails = response.data!;

      return ApiResponse(
          success: true,
          statusCode: 200,
          message: "Success",
          data: dashboardDetails);
    }

    return ApiResponse(
      success: false,
      statusCode: response.statusCode,
      message: response.message,
      data: [],
    );
  }

  Future<ApiResponse<Map<String, List<User>>>> getUsersForTasks(
      List<String> taskIds) async {
    final response = await repository.fetchUsersForTask(taskIds);

    if (response.success && response.data != null) {
      Map<String, List<User>> dashboardDetails = response.data!;

      return ApiResponse(
          success: true,
          statusCode: 200,
          message: "Success",
          data: dashboardDetails);
    }

    return ApiResponse(
      success: false,
      statusCode: response.statusCode,
      message: response.message,
      data: {},
    );
  }

  Future<ApiResponse<Task>> getTask(String id) async {
    final response = await repository.fetchTask(id);

    if (response.success && response.data != null) {
      Task task = response.data!;

      return ApiResponse(
        success: true,
        statusCode: 200,
        message: "Success",
        data: task,
      );
    }

    return ApiResponse(
      success: false,
      statusCode: response.statusCode,
      message: response.message,
    );
  }
}
