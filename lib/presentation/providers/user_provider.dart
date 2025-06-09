import 'package:flutter/material.dart';

import '../../data/models/api/api_error.dart';
import '../../data/repositories/user_repository.dart';
import '../../domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _repository;

  UserProvider(this._repository);

  List<User> _users = [];
  List<User> get users => _users;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ApiError? _error;
  ApiError? get error => _error;

  Future<void> fetchAllUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _repository.getAll();

    result.fold(
      (err) {
        _error = err;
        _users = [];
      },
      (userList) {
        _users = userList;
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
