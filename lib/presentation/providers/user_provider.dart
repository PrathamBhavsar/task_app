import 'package:flutter/material.dart';

import '../../core/dto/user_dto.dart';
import '../../data/models/user.dart';
import '../../domain/use_cases/user_use_cases.dart';

class UserProvider extends ChangeNotifier {
  final GetUsersUseCase _getUsersUseCase;

  List<User> _users = [];
  List<User> get users => _users;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserProvider(this._getUsersUseCase);

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    UserDTO requestDTO = UserDTO(action: 'create');
    final response = await _getUsersUseCase.execute(requestDTO);

    if (response.success && response.data != null) {
      _users = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
