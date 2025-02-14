import 'package:flutter/material.dart';

import '../../core/dto/user_dto.dart';
import '../../data/models/user.dart';
import '../../domain/use_cases/local_user_use_cases.dart';
import '../../domain/use_cases/remote_user_use_cases.dart';

class UserProvider extends ChangeNotifier {
  final GetRemoteUsersUseCase _getUsersUseCase;
  final GetLocalUsersUseCase _getLocalUsersUseCase;

  List<User> _users = [];
  List<User> get users => _users;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserProvider(this._getUsersUseCase, this._getLocalUsersUseCase);

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    ///try local db first
    // _customers = await _getLocalUsersUseCase.execute();
    //
    // if (_customers.isNotEmpty) {
    //   _isLoading = false;
    //   notifyListeners();
    //   return;
    // }

    UserDTO requestDTO = UserDTO(action: 'create');
    final response = await _getUsersUseCase.execute(requestDTO);

    if (response.success && response.data != null) {
      _users = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
