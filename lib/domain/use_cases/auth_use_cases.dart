import '../../core/constants/enums/user_role.dart';
import '../../core/dto/login_dto.dart';
import '../../core/dto/register_dto.dart';
import '../../data/models/api_response.dart';
import '../../data/models/user.dart';
import '../../data/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  Future<ApiResponse<User>> fetchCurrentUser() async =>
      await _repository.fetchCurrentUser();

  Future<ApiResponse<User>> login(LoginUserDTO loginUserDTO) async {
    final response = await _repository.login(loginUserDTO);
    return response;
  }

  Future<ApiResponse<User>> register(RegisterUserDTO registerUserDtO) async {
    final response = await _repository.register(registerUserDtO);
    return response;
  }

  Future<void> logout() async {
    await _repository.logout();
  }
}
