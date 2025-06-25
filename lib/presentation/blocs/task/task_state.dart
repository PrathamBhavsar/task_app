import '../../../core/error/failure.dart';
import '../../../domain/entities/task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoadInProgress extends TaskState {}

class TaskLoadSuccess extends TaskState {
  final List<Task> tasks;

  TaskLoadSuccess(this.tasks);
}

class TaskLoadFailure extends TaskState {
  final Failure error;

  TaskLoadFailure(this.error);
}

class PutTaskInProgress extends TaskState {}

class PutTaskSuccess extends TaskState {
  final Task message;

  PutTaskSuccess(this.message);
}

class PutTaskFailure extends TaskState {
  final Failure error;

  PutTaskFailure(this.error);
}

class UpdateTaskStatusInProgress extends TaskState {}

class UpdateTaskStatusSuccess extends TaskState {
  final Task message;

  UpdateTaskStatusSuccess(this.message);
}

class UpdateTaskStatusFailure extends TaskState {
  final Failure error;

  UpdateTaskStatusFailure(this.error);
}

class TaskSelectionState extends TaskState {
  final bool isProductSelected;

  TaskSelectionState({required this.isProductSelected});
}

