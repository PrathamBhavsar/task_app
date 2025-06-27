import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_measurements_usecase.dart';
import '../../../../domain/usecases/put_measurement_usecase.dart';
import 'measurement_api_event.dart';
import 'measurement_api_state.dart';

class MeasurementApiBloc
    extends Bloc<MeasurementApiEvent, MeasurementApiState> {
  final GetAllMeasurementsUseCase _getAllMeasurementsUseCase;
  final PutMeasurementUseCase _putMeasurementUseCase;

  MeasurementApiBloc(
    this._getAllMeasurementsUseCase,
    this._putMeasurementUseCase,
  ) : super(MeasurementInitial()) {
    on<FetchMeasurementsRequested>(_onFetchMeasurements);
    on<PutMeasurementRequested>(_onPutMeasurement);
  }

  Future<void> _onFetchMeasurements(
    FetchMeasurementsRequested event,
    Emitter<MeasurementApiState> emit,
  ) async {
    emit(MeasurementLoadInProgress());

    final result = await _getAllMeasurementsUseCase(event.taskId);

    result.fold(
      (failure) => emit(MeasurementLoadFailure(failure)),
      (measurements) => emit(MeasurementLoadSuccess(measurements)),
    );
  }

  Future<void> _onPutMeasurement(
    PutMeasurementRequested event,
    Emitter<MeasurementApiState> emit,
  ) async {
    emit(MeasurementLoadInProgress());

    final result = await _putMeasurementUseCase(event.data);

    result.fold((failure) => emit(PutMeasurementFailure(failure)), (
      measurements,
    ) {
      emit(PutMeasurementSuccess(measurements));
    });
  }
}
