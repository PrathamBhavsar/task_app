import 'package:sqflite/sqflite.dart';
import '../../core/constants/local_db.dart';
import '../../core/database/database_helper.dart';
import '../../core/dto/designer_dto.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../models/api_response.dart';
import '../models/designer.dart';

class DesignerRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<ApiResponse<List<Designer>>> fetchDesigners(
      DesignerDTO requestDTO) async {
    try {
      /// Try designers from local DB first
      List<Designer> localDesigners = await getDesignersFromDB();
      if (localDesigners.isNotEmpty) {
        return ApiResponse(
          success: true,
          statusCode: 200,
          message: "Fetched from local DB",
          data: localDesigners,
        );
      }

      final response = await _apiManager.get<List<Designer>>(
        ApiEndpoints.designer,
        fromJsonT: (data) =>
            (data as List).map((e) => Designer.fromJson(e)).toList(),
      );

      // Store designers in local DB
      if (response.success && response.data != null) {
        await _storeDesignersInDB(response.data!);
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

  /// Store designers in local database
  Future<void> _storeDesignersInDB(List<Designer> designers) async {
    var db = await _dbHelper.database;
    for (var designer in designers) {
      await db.insert(
        LocalDbKeys.designersTable,
        designer.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  /// Get designers from local database
  Future<List<Designer>> getDesignersFromDB() async {
    var db = await _dbHelper.database;
    var result = await db.query(LocalDbKeys.designersTable);
    return result.map(Designer.fromJson).toList();
  }

  /// Insert or update designer
  Future<void> insertOrUpdateDesigner(Designer designer) async {
    var db = await _dbHelper.database;
    await db.insert(
      LocalDbKeys.designersTable,
      designer.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Delete all designers from local database
  Future<void> deleteAllDesigners() async {
    var db = await _dbHelper.database;
    await db.delete(LocalDbKeys.designersTable);
  }
}
