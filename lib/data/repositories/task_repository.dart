import '../../core/database/database_helper.dart';
import '../../core/dto/get_tasks_dto.dart';
import '../../core/dto/task_dtos.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../../utils/constants/local_db.dart';
import '../models/api_response.dart';
import '../models/dashboard_detail.dart';
import '../models/task.dart';
import '../models/taskWithUser.dart';

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

  Future<ApiResponse<Map<String, dynamic>>> createTask(
      CreateTaskDTO requestDTO) async {
    try {
      // Fetch from API
      final response = await _apiManager.post<Map<String, dynamic>>(
        data: requestDTO.toJson(),
        ApiEndpoints.task,
        fromJsonT: (data) => data,
      );

      if (response.success && response.data != null) {
        await _dbHelper.storeAllData(LocalDbKeys.taskTable, [response.data!]);
      }

      return response;
    } catch (e) {
      return ApiResponse<Map<String, dynamic>>(
        success: false,
        statusCode: 500,
        message: "Failed to create task: $e",
        data: {},
      );
    }
  }

  Future<ApiResponse<List<TaskWithUsers>>> fetchTasksOverall(
      GetTasksDTO requestDTO) async {
    try {
      // Step 1: Try fetching from local database
      List<TaskWithUsers> localTasks = await _dbHelper.getTaskOverall();

      if (localTasks.isNotEmpty) {
        return ApiResponse(
          success: true,
          statusCode: 200,
          message: "Fetched from local DB",
          data: localTasks,
        );
      }

      final remoteResponse = await fetchTasks(requestDTO);

      if (!remoteResponse.success) {
        return ApiResponse(
          success: false,
          statusCode: remoteResponse.statusCode,
          message: "Failed to fetch from remote",
          data: [],
        );
      }

      // Step 3: Fetch enriched data from local DB after syncing
      localTasks = await _dbHelper.getTaskOverall();

      return ApiResponse(
        success: true,
        statusCode: 200,
        message: "Fetched from local DB after remote sync",
        data: localTasks,
      );
    } catch (e) {
      return ApiResponse<List<TaskWithUsers>>(
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
