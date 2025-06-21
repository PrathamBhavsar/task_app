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