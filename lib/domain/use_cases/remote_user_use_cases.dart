import '../../../data/models/api_response.dart';
import '../../core/dto/user_dto.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';

class GetRemoteUsersUseCase {
  final UserRepository repository;

  GetRemoteUsersUseCase(this.repository);

  Future<ApiResponse<List<User>>> execute(UserDTO userDTO) async {
    final response = await repository.fetchUsers(userDTO);

    if (response.success && response.data != null) {
      List<User> users = List<User>.from(response.data!);

      return ApiResponse(
          success: true, statusCode: 200, message: "Success", data: users);
    }

    return ApiResponse(
        success: false,
        statusCode: response.statusCode,
        message: response.message,
        data: []);
  }
}
