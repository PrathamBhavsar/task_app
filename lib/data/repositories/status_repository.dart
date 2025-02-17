import '../../core/constants/local_db.dart';
import '../../core/database/database_helper.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../models/api_response.dart';
import '../models/status.dart';

class StatusRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<ApiResponse<List<Status>>> fetchStatuses() async {
    try {
      // Try fetching statuses from the local database
      List<Map<String, dynamic>> localData =
          await _dbHelper.getAll(LocalDbKeys.statusesTable);
      List<Status> localStatuses = localData.map(Status.fromJson).toList();

      if (localStatuses.isNotEmpty) {
        return ApiResponse(
          success: true,
          statusCode: 200,
          message: "Fetched from local DB",
          data: localStatuses,
        );
      }

      // Fetch from API if no local data exists
      final response = await _apiManager.get<List<Status>>(
        ApiEndpoints.status,
        fromJsonT: (data) =>
            (data as List).map((e) => Status.fromJson(e)).toList(),
      );

      if (response.success && response.data != null) {
        await _dbHelper.storeAllData(LocalDbKeys.statusesTable,
            response.data!.map((c) => c.toJson()).toList());
      }

      return response;
    } catch (e) {
      return ApiResponse<List<Status>>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch statuses: $e",
        data: [],
      );
    }
  }

  /// Insert or update a status in the local database
  Future<void> insertOrUpdateStatus(Status status) async {
    await _dbHelper.insertOrUpdate(LocalDbKeys.statusesTable, status.toJson());
  }

  /// Delete all statuses from the local database
  Future<void> deleteAllStatuses() async {
    await _dbHelper.deleteAll(LocalDbKeys.statusesTable);
  }
}
