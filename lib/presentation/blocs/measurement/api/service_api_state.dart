import '../../../../core/error/failure.dart';
import '../../../../domain/entities/service.dart';
import '../../../../domain/entities/service_master.dart';

abstract class ServiceApiState {}

class ServiceInitial extends ServiceApiState {}

class ServiceLoadInProgress extends ServiceApiState {}

class ServiceLoadSuccess extends ServiceApiState {
  final List<Service> services;

  ServiceLoadSuccess(this.services);
}

class ServiceLoadFailure extends ServiceApiState {
  final Failure error;

  ServiceLoadFailure(this.error);
}

class PutServiceInProgress extends ServiceApiState {}

class PutServiceSuccess extends ServiceApiState {
  final List<Service> service;

  PutServiceSuccess(this.service);
}

class PutServiceFailure extends ServiceApiState {
  final Failure error;

  PutServiceFailure(this.error);
}

class ServiceMasterInitial extends ServiceApiState {}

class ServiceMasterLoadInProgress extends ServiceApiState {}

class ServiceMasterLoadSuccess extends ServiceApiState {
  final List<ServiceMaster> serviceMasters;

  ServiceMasterLoadSuccess(this.serviceMasters);
}

class ServiceMasterLoadFailure extends ServiceApiState {
  final Failure error;

  ServiceMasterLoadFailure(this.error);
}
