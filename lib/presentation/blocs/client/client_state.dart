import '../../../core/error/failure.dart';
import '../../../domain/entities/client.dart';

abstract class ClientState {}

class ClientInitial extends ClientState {}

class ClientLoadInProgress extends ClientState {}

class ClientLoadSuccess extends ClientState {
  final List<Client> clients;

  ClientLoadSuccess(this.clients);
}

class ClientLoadFailure extends ClientState {
  final Failure error;

  ClientLoadFailure(this.error);
}

class PutClientInitial extends ClientState {}

class PutClientInProgress extends ClientState {}

class PutClientSuccess extends ClientState {
  final Client client;

  PutClientSuccess(this.client);
}

class PutClientFailure extends ClientState {
  final Failure error;

  PutClientFailure(this.error);
}
