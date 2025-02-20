import 'package:flutter/material.dart';

import '../../data/models/api_response.dart';
import '../../data/models/status.dart';
import '../../data/models/user.dart';
import '../../data/models/priority.dart';
import '../../data/models/designer.dart';
import '../../data/models/client.dart';
import '../../domain/use_cases/status_use_cases.dart';
import '../../domain/use_cases/priority_use_cases.dart';
import '../../domain/use_cases/designer_use_cases.dart';
import '../../domain/use_cases/client_use_cases.dart';
import '../../domain/use_cases/user_use_cases.dart';

class HomeProvider extends ChangeNotifier {
  final GetStatusesUseCase _getStatusesUseCase;
  final GetPrioritiesUseCase _getPrioritiesUseCase;
  final GetDesignersUseCase _getDesignersUseCase;
  final GetClientsUseCase _getClientsUseCase;
  final GetUsersUseCase _getUsersUseCase;

  List<Status> _statuses = [];
  List<Priority> _priorities = [];
  List<Designer> _designers = [];
  List<Client> _clients = [];
  List<User> _users = [];

  List<Status> get statuses => _statuses;
  List<Priority> get priorities => _priorities;
  List<Designer> get designers => _designers;
  List<Client> get clients => _clients;
  List<User> get users => _users;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  HomeProvider({
    required GetStatusesUseCase getStatusesUseCase,
    required GetPrioritiesUseCase getPrioritiesUseCase,
    required GetDesignersUseCase getDesignersUseCase,
    required GetClientsUseCase getClientsUseCase,
    required GetUsersUseCase getUsersUseCase,
  })  : _getStatusesUseCase = getStatusesUseCase,
        _getPrioritiesUseCase = getPrioritiesUseCase,
        _getDesignersUseCase = getDesignersUseCase,
        _getClientsUseCase = getClientsUseCase,
        _getUsersUseCase = getUsersUseCase;

  Future<void> fetchAllData() async {
    _isLoading = true;
    notifyListeners();

    final List<ApiResponse<dynamic>> responses = await Future.wait([
      _getStatusesUseCase.execute(),
      _getPrioritiesUseCase.execute(),
      _getDesignersUseCase.execute(),
      _getClientsUseCase.execute(),
      _getUsersUseCase.execute(),
    ]);

    _statuses = responses[0].success ? responses[0].data ?? [] : [];
    _priorities = responses[1].success ? responses[1].data ?? [] : [];
    _designers = responses[2].success ? responses[2].data ?? [] : [];
    _clients = responses[3].success ? responses[3].data ?? [] : [];
    _users = responses[4].success ? responses[4].data ?? [] : [];

    print(_statuses);
    print(_priorities);
    print(_designers);
    print(_clients);
    print(_users);

    _isLoading = false;
    notifyListeners();
  }
}
