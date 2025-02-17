import 'package:flutter/material.dart';

import '../../data/models/status.dart';
import '../../data/models/priority.dart';
import '../../data/models/designer.dart';
import '../../data/models/client.dart';
import '../../domain/use_cases/status_use_cases.dart';
import '../../domain/use_cases/priority_use_cases.dart';
import '../../domain/use_cases/designer_use_cases.dart';
import '../../domain/use_cases/client_use_cases.dart';

class HomeProvider extends ChangeNotifier {
  final GetStatusesUseCase _getStatusesUseCase;
  final GetPrioritiesUseCase _getPrioritiesUseCase;
  final GetDesignersUseCase _getDesignersUseCase;
  final GetClientsUseCase _getClientsUseCase;

  // Data lists
  List<Status> _statuses = [];
  List<Priority> _priorities = [];
  List<Designer> _designers = [];
  List<Client> _clients = [];

  // Getters for each list
  List<Status> get statuses => _statuses;
  List<Priority> get priorities => _priorities;
  List<Designer> get designers => _designers;
  List<Client> get clients => _clients;

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  HomeProvider({
    required GetStatusesUseCase getStatusesUseCase,
    required GetPrioritiesUseCase getPrioritiesUseCase,
    required GetDesignersUseCase getDesignersUseCase,
    required GetClientsUseCase getClientsUseCase,
  })  : _getStatusesUseCase = getStatusesUseCase,
        _getPrioritiesUseCase = getPrioritiesUseCase,
        _getDesignersUseCase = getDesignersUseCase,
        _getClientsUseCase = getClientsUseCase;

  // Fetch all data
  Future<void> fetchAllData() async {
    _isLoading = true;
    notifyListeners();

    // Fetch statuses
    final statusResponse = await _getStatusesUseCase.execute();
    if (statusResponse.success && statusResponse.data != null) {
      _statuses = statusResponse.data!;
    }

    // Fetch priorities
    final priorityResponse = await _getPrioritiesUseCase.execute();
    if (priorityResponse.success && priorityResponse.data != null) {
      _priorities = priorityResponse.data!;
    }

    // Fetch designers
    final designerResponse = await _getDesignersUseCase.execute();
    if (designerResponse.success && designerResponse.data != null) {
      _designers = designerResponse.data!;
    }

    // Fetch clients
    final clientResponse = await _getClientsUseCase.execute();
    if (clientResponse.success && clientResponse.data != null) {
      _clients = clientResponse.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
