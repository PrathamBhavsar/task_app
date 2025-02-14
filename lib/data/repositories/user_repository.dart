import 'package:sqflite/sqflite.dart';
import '../../core/constants/local_db.dart';
import '../../core/database/database_helper.dart';
import '../../core/dto/user_dto.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../models/api_response.dart';

class UserRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<ApiResponse<List<String>>> fetchUsers(UserDTO requestDTO) async {
    try {
      final response = await _apiManager.post<List<String>>(
        ApiEndpoints.user,
        fromJsonT: (data) => (data as List).map((e) => e.toString()).toList(),
      );

      if (response.success && response.data != null) {
        await _storeUsersInDB(response.data!);
      }
      return response;
    } catch (e) {
      return ApiResponse<List<String>>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch users: $e",
        data: [],
      );
    }
  }

  Future<void> _storeUsersInDB(List<String> users) async {
    var db = await _dbHelper.database;
    Batch batch = db.batch();

    for (var user in users) {
      batch.insert(
        LocalDbKeys.usersTable,
        {"name": user},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<String>> getUsersFromDB() async {
    var db = await _dbHelper.database;
    var result = await db.query("users");

    return result.map((row) => row["name"] as String).toList();
  }
}
