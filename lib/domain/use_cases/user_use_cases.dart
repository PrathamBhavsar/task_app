import '../../../data/models/api_response.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase(this.repository);

  Future<ApiResponse<List<User>>> execute() async {
    final response = await repository.fetchUsers();

    if (response.success && response.data != null) {
      List<User> users = List<User>.from(response.data!);

      return ApiResponse(
          success: true, statusCode: 200, message: "Success", data: users);
    }

    return ApiResponse(
      success: false,
      statusCode: response.statusCode,
      message: response.message,
      data: [],
    );
  }
}
