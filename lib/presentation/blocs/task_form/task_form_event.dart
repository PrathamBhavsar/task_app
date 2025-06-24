import '../../../domain/entities/client.dart';
import '../../../domain/entities/designer.dart';
import '../../../domain/entities/priority.dart';
import '../../../domain/entities/status.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/user.dart';

abstract class TaskFormEvent {}

class InitializeTaskForm extends TaskFormEvent {
  final Task? existingTask;
  final List<Client> clients;
  final List<Designer> designers;
  final List<User> agencies;

  InitializeTaskForm({
    required this.clients,
    required this.designers,
    required this.agencies,
    this.existingTask,
  });
}

class ResetTaskForm extends TaskFormEvent {
  final List<Client> clients;
  final List<User> agencies;
  final List<Designer> designers;

  ResetTaskForm({
    required this.clients,
    required this.designers,
    required this.agencies,
  });
}

class StatusChanged extends TaskFormEvent {
  final Status status;

  StatusChanged(this.status);
}

class PriorityChanged extends TaskFormEvent {
  final Priority priority;

  PriorityChanged(this.priority);
}

class ClientChanged extends TaskFormEvent {
  final Client client;

  ClientChanged(this.client);
}

class DesignerChanged extends TaskFormEvent {
  final Designer designer;

  DesignerChanged(this.designer);
}

class AgencyChanged extends TaskFormEvent {
  final User agency;

  AgencyChanged(this.agency);
}
