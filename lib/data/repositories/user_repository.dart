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
      final response = await _apiManager.get<List<User>>(
        ApiEndpoints.user,
        fromJsonT: (data) =>
            (data as List).map((e) => User.fromJson(e)).toList(),
      );

      if (response.success && response.data != null) {
        await _storeUsersInDB(response.data!);
      }

      return response;
    } catch (e) {
      return ApiResponse<List<User>>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch products: $e",
        data: [],
      );
    }
  }

  Future<void> _storeUsersInDB(List<User> products) async {
    var db = await _dbHelper.database;
    for (var product in products) {
      await db.insert(
        LocalDbKeys.usersTable,
        product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<User>> getUsersFromDB() async {
    var db = await _dbHelper.database;
    var result = await db.query(LocalDbKeys.usersTable);
    return result.map(User.fromJson).toList();
  }

  Future<void> deleteAllUsers() async {
    var db = await _dbHelper.database;
    await db.delete(LocalDbKeys.usersTable);
  }
}
