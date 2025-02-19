import '../../core/database/database_helper.dart';
import '../../core/dto/get_tasks_dto.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../../utils/constants/local_db.dart';
import '../models/api_response.dart';
import '../models/dashboard_detail.dart';
import '../models/task.dart';
import '../models/user.dart';

class TaskRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<ApiResponse<List<Task>>> fetchTasks(GetTasksDTO requestDTO) async {
    try {
      // Try fetching tasks from the local database
      List<Map<String, dynamic>> localData =
          await _dbHelper.getAll(LocalDbKeys.taskTable);
      List<Task> localTasks = localData.map(Task.fromJson).toList();

      if (localTasks.isNotEmpty) {
        return ApiResponse(
          success: true,
          statusCode: 200,
          message: "Fetched from local DB",
          data: localTasks,
        );
      }

      // Fetch from API if no local data exists
      final response = await _apiManager.post<List<Task>>(
        data: requestDTO.toJson(),
        ApiEndpoints.task,
        fromJsonT: (data) =>
            (data as List).map((e) => Task.fromJson(e)).toList(),
      );

      if (response.success && response.data != null) {
        await _dbHelper.storeAllData(LocalDbKeys.taskTable,
            response.data!.map((c) => c.toJson()).toList());
      }

      return response;
    } catch (e) {
      return ApiResponse<List<Task>>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch tasks: $e",
        data: [],
      );
    }
  }

  /// For Dashboard
  Future<ApiResponse<List<DashboardStatus>>> dashBoardDetails() async {
    List<DashboardStatus> dashboardData =
        await _dbHelper.getTaskCountPerStatus();
    if (dashboardData.isNotEmpty) {
      return ApiResponse(
        success: true,
        statusCode: 200,
        message: "Fetched dashboard details from local DB",
        data: dashboardData,
      );
    }
    return ApiResponse(
      success: false,
      statusCode: 500,
      message: "Failed to fetch dashboard details",
      data: [],
    );
  }

  /// For Dashboard
  Future<ApiResponse<Map<String, List<User>>>> fetchUsersForTask(
      List<String> taskIds) async {
    Map<String, List<User>> users = await _dbHelper.getUsersForTasks(taskIds);
    if (users.isNotEmpty) {
      return ApiResponse(
        success: true,
        statusCode: 200,
        message: "Fetched task users from local DB",
        data: users,
      );
    }
    return ApiResponse(
      success: false,
      statusCode: 500,
      message: "Failed to fetch task users",
      data: {},
    );
  }

  Future<ApiResponse<Task>> fetchTask(String id) async {
    Task? dashboardData = await _dbHelper.getTaskById(id);
    if (dashboardData != null) {
      return ApiResponse(
        success: true,
        statusCode: 200,
        message: "Fetched task from local DB",
        data: dashboardData,
      );
    }
    return ApiResponse(
      success: false,
      statusCode: 500,
      message: "Failed to fetch task",
    );
  }

  /// Insert or update a task in the local database
  Future<void> insertOrUpdateTask(Task task) async {
    await _dbHelper.insertOrUpdate(LocalDbKeys.taskTable, task.toJson());
  }

  /// Delete all tasks from the local database
  Future<void> deleteAllTasks() async {
    await _dbHelper.deleteAll(LocalDbKeys.taskTable);
  }
}
