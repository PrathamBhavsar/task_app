import 'package:flutter/material.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/client.dart';

/// --- FETCH STATES ---
@immutable
sealed class GetClientsState {}

class None extends GetClientsState {}

class Fetching extends GetClientsState {}

class Fetched extends GetClientsState {
  final List<Client> clients;

  Fetched(this.clients);
}

class Failed extends GetClientsState {
  final Failure failure;

  Failed(this.failure);
}
