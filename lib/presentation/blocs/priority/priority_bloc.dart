import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/priority_usecase.dart';
import '../../../domain/usecases/status_usecase.dart';
import 'priority_event.dart';
import 'priority_state.dart';

class PriorityBloc extends Bloc<PriorityEvent, PriorityState> {
  final GetAllPrioritiesUseCase _getAllPrioritiesUseCase;

  PriorityBloc(this._getAllPrioritiesUseCase) : super(PriorityInitial()) {
    on<FetchPrioritiesRequested>(_onFetchPriorities);
  }

  Future<void> _onFetchPriorities(
    FetchPrioritiesRequested event,
    Emitter<PriorityState> emit,
  ) async {
    emit(PriorityLoadInProgress());
    final result = await _getAllPrioritiesUseCase();
    result.fold(
      (failure) => emit(PriorityLoadFailure(failure)),
      (bills) => emit(PriorityLoadSuccess(bills)),
    );
  }
}
