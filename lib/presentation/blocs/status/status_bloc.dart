import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/status_usecase.dart';
import 'status_event.dart';
import 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final GetAllStatusesUseCase _getAllStatusesUseCase;

  StatusBloc(this._getAllStatusesUseCase) : super(StatusInitial()) {
    on<FetchStatusesRequested>(_onFetchStatuss);
  }

  Future<void> _onFetchStatuss(
    FetchStatusesRequested event,
    Emitter<StatusState> emit,
  ) async {
    emit(StatusLoadInProgress());
    final result = await _getAllStatusesUseCase();
    result.fold(
      (failure) => emit(StatusLoadFailure(failure)),
      (bills) => emit(StatusLoadSuccess(bills)),
    );
  }
}
