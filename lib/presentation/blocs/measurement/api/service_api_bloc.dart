import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/cache_helper.dart';
import '../../../../domain/usecases/get_service_masters_usecase.dart';
import '../../../../domain/usecases/get_services_usecase.dart';
import '../../../../domain/usecases/put_service_usecase.dart';
import 'service_api_event.dart';
import 'service_api_state.dart';

class ServiceApiBloc
    extends Bloc<ServiceApiEvent, ServiceApiState> {
  final CacheHelper _cache;
  final GetAllServiceMastersUseCase _getAllServiceMastersUseCase;
  final GetAllServicesUseCase _getAllServicesUseCase;
  final PutServiceUseCase _putServiceUseCase;

  ServiceApiBloc(
      this._cache,
    this._getAllServicesUseCase,
    this._putServiceUseCase,
    this._getAllServiceMastersUseCase,
  ) : super(ServiceInitial()) {
    on<FetchServicesRequested>(_onFetchServices);
    on<PutServiceRequested>(_onPutService);
    on<FetchServiceMastersRequested>(_onFetchServiceMasters);
  }

  Future<void> _onFetchServices(
    FetchServicesRequested event,
    Emitter<ServiceApiState> emit,
  ) async {
    emit(ServiceLoadInProgress());

    final result = await _getAllServicesUseCase(event.taskId);

    result.fold(
      (failure) => emit(ServiceLoadFailure(failure)),
      (services) => emit(ServiceLoadSuccess(services)),
    );
  }
  Future<void> _onFetchServiceMasters(
    FetchServiceMastersRequested event,
    Emitter<ServiceApiState> emit,
  ) async {
    emit(ServiceMasterLoadInProgress());

    final result = await _getAllServiceMastersUseCase();

    result.fold(
      (failure) => emit(ServiceMasterLoadFailure(failure)),
      (services) {
        _cache.setServiceMasters(services);
        emit(ServiceMasterLoadSuccess(services));
      },
    );
  }

  Future<void> _onPutService(
    PutServiceRequested event,
    Emitter<ServiceApiState> emit,
  ) async {
    emit(ServiceLoadInProgress());

    final result = await _putServiceUseCase(event.data);

    result.fold((failure) => emit(PutServiceFailure(failure)), (
      services,
    ) {
      emit(PutServiceSuccess(services));
    });
  }
}
