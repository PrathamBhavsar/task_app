import '../../core/constants/local_db.dart';
import '../../core/database/database_helper.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../models/api_response.dart';
import '../models/designer.dart';

class DesignerRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<ApiResponse<List<Designer>>> fetchDesigners() async {
    try {
      // Try fetching designers from the local database
      List<Map<String, dynamic>> localData =
          await _dbHelper.getAll(LocalDbKeys.designerTable);
      List<Designer> localDesigners = localData.map(Designer.fromJson).toList();

      if (localDesigners.isNotEmpty) {
        return ApiResponse(
          success: true,
          statusCode: 200,
          message: "Fetched from local DB",
          data: localDesigners,
        );
      }

      // Fetch from API if no local data exists
      final response = await _apiManager.get<List<Designer>>(
        ApiEndpoints.designer,
        fromJsonT: (data) =>
            (data as List).map((e) => Designer.fromJson(e)).toList(),
      );

      if (response.success && response.data != null) {
        await _dbHelper.storeAllData(LocalDbKeys.designerTable,
            response.data!.map((c) => c.toJson()).toList());
      }

      return response;
    } catch (e) {
      return ApiResponse<List<Designer>>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch designers: $e",
        data: [],
      );
    }
  }

  /// Insert or update a designer in the local database
  Future<void> insertOrUpdateDesigner(Designer designer) async {
    await _dbHelper.insertOrUpdate(
        LocalDbKeys.designerTable, designer.toJson());
  }

  /// Delete all designers from the local database
  Future<void> deleteAllDesigners() async {
    await _dbHelper.deleteAll(LocalDbKeys.designerTable);
  }
}
