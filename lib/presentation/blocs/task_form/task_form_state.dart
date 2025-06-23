import '../../../domain/entities/client.dart';
import '../../../domain/entities/priority.dart';
import '../../../domain/entities/status.dart';
import '../../../domain/entities/user.dart';

class TaskFormState {
  final Status? selectedStatus;
  final Priority? selectedPriority;
  final Client? selectedClient;
  final User? selectedAgency;

  final List<Status> statuses;
  final List<Priority> priorities;
  final List<Client> clients;
  final List<User> agencies;

  TaskFormState({
    required this.selectedStatus,
    required this.selectedPriority,
    required this.selectedClient,
    required this.selectedAgency,
    required this.statuses,
    required this.priorities,
    required this.clients,
    required this.agencies,
  });

  TaskFormState copyWith({
    Status? selectedStatus,
    Priority? selectedPriority,
    Client? selectedCustomer,
    User? selectedAgency,
    List<Status>? statuses,
    List<Priority>? priorities,
    List<Client>? customers,
    List<User>? agencies,
  }) {
    return TaskFormState(
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedClient: selectedCustomer ?? this.selectedClient,
      selectedAgency: selectedAgency ?? this.selectedAgency,
      statuses: statuses ?? this.statuses,
      priorities: priorities ?? this.priorities,
      clients: customers ?? this.clients,
      agencies: agencies ?? this.agencies,
    );
  }
}
