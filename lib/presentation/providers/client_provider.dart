import 'package:flutter/material.dart';

import '../../core/dto/client_dto.dart';
import '../../core/dto/user_dto.dart';
import '../../data/models/client.dart';
import '../../data/models/user.dart';
import '../../domain/use_cases/client_use_cases.dart';
import '../../domain/use_cases/user_use_cases.dart';

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

    ClientDTO requestDTO = ClientDTO(
      action: 'create',
      name: '',
      address: '',
      contactNo: '',
    );
    final response = await _getClientsUseCase.execute(requestDTO);

    if (response.success && response.data != null) {
      _clients = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
