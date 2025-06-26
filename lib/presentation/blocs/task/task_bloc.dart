import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/snack_bar_helper.dart';
import '../../../domain/usecases/put_task_usecase.dart';
import '../../../domain/usecases/task_usecase.dart';
import '../../../domain/usecases/update_task_status_usecase.dart';
import '../../../domain/usecases/update_task_usecase.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final SnackBarHelper _snackBarHelper;
  final GetAllTasksUseCase _getAllTasksUseCase;
  final PutTaskUseCase _putTaskUseCase;
  final UpdateTaskStatusUseCase _updateTaskStatusUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;

  TaskBloc(
    this._getAllTasksUseCase,
    this._putTaskUseCase,
    this._snackBarHelper,
    this._updateTaskStatusUseCase,
    this._updateTaskUseCase,
  ) : super(TaskInitial()) {
    on<FetchTasksRequested>(_onFetchTasks);
    on<PutTaskRequested>(_onPutTask);
    on<ToggleStatusEvent>(_onToggle);
    on<UpdateTaskStatusRequested>(_onUpdateTaskStatus);
    on<UpdateTaskRequested>(_onUpdateTask);
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
    emit(PutTaskInProgress());

    final result = await _putTaskUseCase(event.data);

    result.fold((failure) => emit(PutTaskFailure(failure)), (message) {
      emit(PutTaskSuccess(message));
      _snackBarHelper.showSuccess("Task created!");
    });
  }

  Future<void> _onUpdateTaskStatus(
    UpdateTaskStatusRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(UpdateTaskStatusInProgress());

    final result = await _updateTaskStatusUseCase(event.data);

    result.fold((failure) => emit(UpdateTaskStatusFailure(failure)), (message) {
      emit(UpdateTaskStatusSuccess(message));
      _snackBarHelper.showSuccess("Status updated!");
    });
  }

  Future<void> _onUpdateTask(
    UpdateTaskRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(UpdateTaskInProgress());

    final result = await _updateTaskUseCase(event.data);

    result.fold((failure) => emit(UpdateTaskFailure(failure)), (task) {
      emit(UpdateTaskSuccess(task));
      _snackBarHelper.showSuccess("Task updated!");
    });
  }

  void _onToggle(ToggleStatusEvent event, Emitter<TaskState> emit) {
    emit(TaskSelectionState(isProductSelected: event.isTrue));
  }
}
