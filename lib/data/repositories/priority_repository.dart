import '../../core/constants/local_db.dart';
import '../../core/database/database_helper.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../models/api_response.dart';
import '../models/priority.dart';

class PriorityRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<ApiResponse<List<Priority>>> fetchPriorities() async {
    try {
      // Try fetching priorities from the local database
      List<Map<String, dynamic>> localData =
          await _dbHelper.getAll(LocalDbKeys.priorityTable);
      List<Priority> localPriorities =
          localData.map(Priority.fromJson).toList();

      if (localPriorities.isNotEmpty) {
        return ApiResponse(
          success: true,
          statusCode: 200,
          message: "Fetched from local DB",
          data: localPriorities,
        );
      }

      // Fetch from API if no local data exists
      final response = await _apiManager.get<List<Priority>>(
        ApiEndpoints.priority,
        fromJsonT: (data) =>
            (data as List).map((e) => Priority.fromJson(e)).toList(),
      );

      if (response.success && response.data != null) {
        await _dbHelper.storeAllData(LocalDbKeys.priorityTable,
            response.data!.map((c) => c.toJson()).toList());
      }

      return response;
    } catch (e) {
      return ApiResponse<List<Priority>>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch priorities: $e",
        data: [],
      );
    }
  }

  /// Insert or update a priority in the local database
  Future<void> insertOrUpdatePriority(Priority priority) async {
    await _dbHelper.insertOrUpdate(
        LocalDbKeys.priorityTable, priority.toJson());
  }

  /// Delete all priorities from the local database
  Future<void> deleteAllPriorities() async {
    await _dbHelper.deleteAll(LocalDbKeys.priorityTable);
  }
}
