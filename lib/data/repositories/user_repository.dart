import '../../core/database/database_helper.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../../utils/constants/local_db.dart';
import '../models/api_response.dart';
import '../models/taskUser.dart';
import '../models/user.dart';

class UserRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<ApiResponse<List<User>>> fetchUsers() async {
    try {
      // Try fetching users from the local database
      List<Map<String, dynamic>> localData =
          await _dbHelper.getAll(LocalDbKeys.userTable);
      List<User> localUsers = localData.map(User.fromJson).toList();

      if (localUsers.isNotEmpty) {
        return ApiResponse(
          success: true,
          statusCode: 200,
          message: "Fetched from local DB",
          data: localUsers,
        );
      }

      // Fetch from API if no local data exists
      final response = await _apiManager.get<List<User>>(
        ApiEndpoints.user,
        fromJsonT: (data) =>
            (data as List).map((e) => User.fromJson(e)).toList(),
      );

      if (response.success && response.data != null) {
        await _dbHelper.storeAllData(LocalDbKeys.userTable,
            response.data!.map((c) => c.toJson()).toList());
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

  /// Insert or update a user in the local database
  Future<void> insertOrUpdateUser(User user) async {
    await _dbHelper.insertOrUpdate(LocalDbKeys.userTable, user.toJson());
  }

  /// Delete all users from the local database
  Future<void> deleteAllUsers() async {
    await _dbHelper.deleteAll(LocalDbKeys.userTable);
  }
}
