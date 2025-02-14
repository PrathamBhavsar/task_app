import 'package:sqflite/sqflite.dart';
import '../../core/constants/local_db.dart';
import '../../core/database/database_helper.dart';
import '../../core/dto/user_dto.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../models/api_response.dart';
import '../models/user.dart';

class UserRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<ApiResponse<List<User>>> fetchUsers(UserDTO requestDTO) async {
    try {
      /// Try users from local DB first
      List<User> localUsers = await getUsersFromDB();
      if (localUsers.isNotEmpty) {
        return ApiResponse(
          success: true,
          statusCode: 200,
          message: "Fetched from local DB",
          data: localUsers,
        );
      }

      final response = await _apiManager.get<List<User>>(
        ApiEndpoints.user,
        fromJsonT: (data) =>
            (data as List).map((e) => User.fromJson(e)).toList(),
      );

      // Store users in local DB
      if (response.success && response.data != null) {
        await _storeUsersInDB(response.data!);
      }

      return response;
    } catch (e) {
      return ApiResponse<List<User>>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch users: $e",
        data: [],
      );
    }
  }

  /// Store users in local database
  Future<void> _storeUsersInDB(List<User> users) async {
    var db = await _dbHelper.database;
    for (var user in users) {
      await db.insert(
        LocalDbKeys.usersTable,
        user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  /// Get users from local database
  Future<List<User>> getUsersFromDB() async {
    var db = await _dbHelper.database;
    var result = await db.query(LocalDbKeys.usersTable);
    return result.map(User.fromJson).toList();
  }

  /// Insert or update user
  Future<void> insertOrUpdateUser(User user) async {
    var db = await _dbHelper.database;
    await db.insert(
      LocalDbKeys.usersTable,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Delete all users from local database
  Future<void> deleteAllUsers() async {
    var db = await _dbHelper.database;
    await db.delete(LocalDbKeys.usersTable);
  }
}
