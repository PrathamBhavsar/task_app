import 'package:flutter/material.dart';

import '../../data/repositories/client_repository.dart';
import '../../data/states/get_clients_states.dart';
import '../../domain/entities/client.dart';

class ClientProvider extends ChangeNotifier {
  final ClientRepository _repository;

  ClientProvider(this._repository);

  List<Client> _clients = [];

  List<Client> get clients => _clients;

  GetClientsState _getClientsState = None();

  GetClientsState get getClientsState => _getClientsState;

  void _setGetClientsState(GetClientsState state) {
    _getClientsState = state;
    notifyListeners();
  }

  Future<void> fetchAllClients() async {
    _setGetClientsState(Fetching());

    notifyListeners();

    final result = await _repository.getAll();

    result.fold(
      (err) {
        _setGetClientsState(Failed(err));
        _clients = [];
      },
      (clientList) {
        _setGetClientsState(Fetched(clientList));

        _clients = clientList;
      },
    );

    notifyListeners();
  }
}
