import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_quote_measurement_usecase.dart';
import 'quote_measurement_event.dart';
import 'quote_measurement_state.dart';

class QuoteMeasurementBloc
    extends Bloc<QuoteMeasurementEvent, QuoteMeasurementState> {
  final GetAllQuoteMeasurementsUseCase _getAllQuoteMeasurementsUseCase;

  QuoteMeasurementBloc(this._getAllQuoteMeasurementsUseCase)
    : super(QuoteMeasurementInitial()) {
    on<FetchQuoteMeasurementsRequested>(_onFetchQuoteMeasurements);
  }

  Future<void> _onFetchQuoteMeasurements(
    FetchQuoteMeasurementsRequested event,
    Emitter<QuoteMeasurementState> emit,
  ) async {
    emit(QuoteMeasurementLoadInProgress());
    final result = await _getAllQuoteMeasurementsUseCase(event.taskId);
    result.fold(
      (failure) => emit(QuoteMeasurementLoadFailure(failure)),
      (quoteMeasurements) =>
          emit(QuoteMeasurementLoadSuccess(quoteMeasurements)),
    );
  }
}
