import '../../core/constants/local_db.dart';
import '../../core/database/database_helper.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../models/api_response.dart';
import '../models/task.dart';

class TaskRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<ApiResponse<List<Task>>> fetchTasks() async {
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
      final response = await _apiManager.get<List<Task>>(
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
        message: "Failed to fetch taskes: $e",
        data: [],
      );
    }
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
