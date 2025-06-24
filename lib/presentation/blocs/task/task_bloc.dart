import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/put_task_usecase.dart';
import '../../../domain/usecases/task_usecase.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasksUseCase _getAllTasksUseCase;
  final PutTaskUseCase _putTaskUseCase;

  TaskBloc(this._getAllTasksUseCase, this._putTaskUseCase)
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

    print(event.data.toJson());
    //   final result = await _putTaskUseCase(event.data);
    //
    //   result.fold((failure) => emit(PutTaskFailure(failure)), (message) {
    //     emit(PutTaskSuccess(message));
    //   });
  }
}
