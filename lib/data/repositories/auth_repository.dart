import '../../core/database/database_helper.dart';
import '../../core/dto/login_dto.dart';
import '../../core/dto/register_dto.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../../utils/constants/local_db.dart';
import '../models/api_response.dart';
import '../models/user.dart';

class AuthRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<ApiResponse<User>> fetchCurrentUser() async {
    try {
      List<Map<String, dynamic>> localUsers =
          await _dbHelper.getAll(LocalDbKeys.userTable);
      if (localUsers.isNotEmpty) {
        User user = localUsers.map(User.fromJson).first;
        await insertOrUpdateUser(user);
        return ApiResponse(
            success: true,
            statusCode: 200,
            data: user,
            message: 'Fetched User from Local Database');
      } else {
        return ApiResponse(
            success: false, statusCode: 404, message: "No user found");
      }
    } catch (e) {
      return ApiResponse<User>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch current user: $e",
      );
    }
  }

  Future<ApiResponse<User>> login(LoginUserDTO requestDTO) async {
    try {
      final response = await _apiManager.post<User>(
        data: requestDTO.toJson(),
        ApiEndpoints.user,
        fromJsonT: (data) => User.fromJson(data),
      );

      if (response.success && response.data != null) {
        await _dbHelper.insertOrUpdate(
          LocalDbKeys.currentUserTable,
          response.data!.toJson(),
        );
      }
      return response;
    } catch (e) {
      return ApiResponse<User>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch users: $e",
      );
    }
  }

  Future<ApiResponse<User>> register(RegisterUserDTO requestDTO) async {
    try {
      final response = await _apiManager.post<User>(
        data: requestDTO.toJson(),
        ApiEndpoints.user,
        fromJsonT: (data) => User.fromJson(data),
      );

      if (response.success && response.data != null) {
        await _dbHelper.insertOrUpdate(
          LocalDbKeys.currentUserTable,
          response.data!.toJson(),
        );
      }
      return response;
    } catch (e) {
      return ApiResponse<User>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch users: $e",
      );
    }
  }

  Future<void> logout() async {
    await deleteAllUsers();
  }

  /// Insert or update a user in the local database
  Future<void> insertOrUpdateUser(User user) async {
    await _dbHelper.insertOrUpdate(LocalDbKeys.currentUserTable, user.toJson());
  }

  /// Delete all users from the local database
  Future<void> deleteAllUsers() async {
    await _dbHelper.deleteAll(LocalDbKeys.currentUserTable);
  }
}
