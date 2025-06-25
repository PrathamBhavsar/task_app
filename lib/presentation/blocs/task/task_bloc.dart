import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/snack_bar_helper.dart';
import '../../../domain/usecases/put_task_usecase.dart';
import '../../../domain/usecases/task_usecase.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final SnackBarHelper _snackBarHelper;
  final GetAllTasksUseCase _getAllTasksUseCase;
  final PutTaskUseCase _putTaskUseCase;

  TaskBloc(this._getAllTasksUseCase, this._putTaskUseCase, this._snackBarHelper)
    : super(TaskInitial()) {
    on<FetchTasksRequested>(_onFetchTasks);
    on<PutTaskRequested>(_onPutTask);
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

  Future<void> _onPutTask(
    PutTaskRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoadInProgress());

    final result = await _putTaskUseCase(event.data);

    result.fold(
      (failure) {
        emit(PutTaskFailure(failure));
        _snackBarHelper.showError(failure.message);
      },
      (message) {
        emit(PutTaskSuccess(message));
        _snackBarHelper.showSuccess("Task created!");
      },
    );
  }
}
