import 'package:flutter/material.dart';

import '../../data/models/client.dart';
import '../../domain/use_cases/client_use_cases.dart';

class ClientProvider extends ChangeNotifier {
  final GetClientsUseCase _getClientsUseCase;

  List<Client> _clients = [];
  List<Client> get clients => _clients;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ClientProvider(this._getClientsUseCase);

  Future<void> fetchClients() async {
    _isLoading = true;
    notifyListeners();

    final response = await _getClientsUseCase.execute();

    if (response.success && response.data != null) {
      _clients = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
