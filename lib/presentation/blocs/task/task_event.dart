import '../../../data/models/payloads/task_payload.dart';
import '../../../data/models/payloads/update_status_payload.dart';

abstract class TaskEvent {}

class FetchTasksRequested extends TaskEvent {}

class PutTaskRequested extends TaskEvent {
  final TaskPayload data;

  PutTaskRequested(this.data);
}

class UpdateTaskRequested extends TaskEvent {
  final TaskPayload data;

  UpdateTaskRequested(this.data);
}

class UpdateTaskStatusRequested extends TaskEvent {
  final UpdateStatusPayload data;

  UpdateTaskStatusRequested(this.data);
}

class ToggleStatusEvent extends TaskEvent {
  final bool isTrue;

  ToggleStatusEvent(this.isTrue);
}
