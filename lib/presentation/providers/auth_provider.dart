import 'package:flutter/material.dart';

import '../../core/constants/enums/user_role.dart';
import '../../core/dto/login_dto.dart';
import '../../core/dto/register_dto.dart';
import '../../data/models/user.dart';
import '../../domain/use_cases/auth_use_cases.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthUseCase _authUseCase;
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  AuthenticationProvider(this._authUseCase);

  Future<void> fetchCurrentUser() async {
    _isLoading = true;
    notifyListeners();

    final response = await _authUseCase.fetchCurrentUser();

    if (response.success && response.data != null) {
      _currentUser = response.data;
    } else {
      _currentUser = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> login(LoginUserDTO loginUserDTO) async {
    _isLoading = true;
    notifyListeners();

    final response = await _authUseCase.login(loginUserDTO);
    if (response.success && response.data != null) {
      _currentUser = response.data;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> register(RegisterUserDTO registerUserDTO) async {
    _isLoading = true;
    notifyListeners();

    final response = await _authUseCase.register(registerUserDTO);
    if (response.success && response.data != null) {
      _currentUser = response.data;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await _authUseCase.logout();
    _currentUser = null;

    _isLoading = false;
    notifyListeners();
  }
}
