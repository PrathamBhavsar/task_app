import '../../../data/models/payloads/client_payload.dart';

abstract class ClientEvent {}
class FetchClientsRequested extends ClientEvent {}
class PutClientRequested extends ClientEvent {
  final ClientPayload data;

  PutClientRequested(this.data);
}
