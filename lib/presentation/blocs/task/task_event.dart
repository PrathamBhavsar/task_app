import '../../../data/models/payloads/task_payload.dart';

abstract class TaskEvent {}
class FetchTasksRequested extends TaskEvent {}

class PutTaskRequested extends TaskEvent {
  final TaskPayload data;

  PutTaskRequested(this.data);
}