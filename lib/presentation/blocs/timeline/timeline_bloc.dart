import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/timeline_usecase.dart';
import 'timeline_event.dart';
import 'timeline_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  final GetAllTimelinesUseCase _getAllTimelinesUseCase;

  TimelineBloc(this._getAllTimelinesUseCase) : super(TimelineInitial()) {
    on<FetchTimelinesRequested>(_onFetchTimelines);
  }

  Future<void> _onFetchTimelines(
      FetchTimelinesRequested event,
      Emitter<TimelineState> emit,
      ) async {
    emit(TimelineLoadInProgress());

    final result = await _getAllTimelinesUseCase(event.taskId);

    result.fold(
          (failure) => emit(TimelineLoadFailure(failure)),
          (timelines) => emit(TimelineLoadSuccess(timelines)),
    );
  }
}
