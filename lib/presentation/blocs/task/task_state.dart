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
