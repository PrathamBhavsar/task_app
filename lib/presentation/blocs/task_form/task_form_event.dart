import '../../../domain/entities/client.dart';
import '../../../domain/entities/priority.dart';
import '../../../domain/entities/status.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/user.dart';

abstract class TaskFormEvent {}

class InitializeTaskForm extends TaskFormEvent {
  final Task? existingTask;

  InitializeTaskForm({this.existingTask});
}

class StatusChanged extends TaskFormEvent {
  final Status status;
  StatusChanged(this.status);
}

class PriorityChanged extends TaskFormEvent {
  final Priority priority;
  PriorityChanged(this.priority);
}

class CustomerChanged extends TaskFormEvent {
  final Client customer;
  CustomerChanged(this.customer);
}

class AgencyChanged extends TaskFormEvent {
  final User agency;
  AgencyChanged(this.agency);
}
