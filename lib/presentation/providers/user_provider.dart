import 'package:flutter/material.dart';

import '../../data/repositories/user_repository.dart';
import '../../data/states/get_users_states.dart';
import '../../domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _repository;

  UserProvider(this._repository);

  List<User> _users = [];

  List<User> get users => _users;

  GetUsersState _getUsersState = None();

  GetUsersState get getUsersState => _getUsersState;

  void _setGetUsersState(GetUsersState state) {
    _getUsersState = state;
    notifyListeners();
  }

  Future<void> fetchAllUsers() async {
    _setGetUsersState(Fetching());

    notifyListeners();

    final result = await _repository.getAll();

    result.fold(
      (err) {
        _setGetUsersState(Failed(err));
        _users = [];
      },
      (userList) {
        _setGetUsersState(Fetched(userList));

        _users = userList;
      },
    );

    notifyListeners();
  }
}
