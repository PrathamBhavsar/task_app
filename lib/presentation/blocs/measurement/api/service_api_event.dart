import '../../../../data/models/payloads/service_payload.dart';

abstract class ServiceApiEvent {}

class FetchServicesRequested extends ServiceApiEvent {
  final int taskId;

  FetchServicesRequested(this.taskId);
}

class PutServiceRequested extends ServiceApiEvent {
  final ServicePayload data;

  PutServiceRequested(this.data);
}

class FetchServiceMastersRequested extends ServiceApiEvent {}
