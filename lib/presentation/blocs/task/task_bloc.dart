import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/task_usecase.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasksUseCase _getAllTasksUseCase;

  TaskBloc(this._getAllTasksUseCase) : super(TaskInitial()) {
    on<FetchTasksRequested>(_onFetchTasks);
  }

  Future<void> _onFetchTasks(
    FetchTasksRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoadInProgress());
    final result = await _getAllTasksUseCase();
    result.fold(
      (failure) => emit(TaskLoadFailure(failure)),
      (tasks) => emit(TaskLoadSuccess(tasks)),
    );
  }
}
