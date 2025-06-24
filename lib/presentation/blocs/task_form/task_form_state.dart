import '../../../domain/entities/client.dart';
import '../../../domain/entities/designer.dart';
import '../../../domain/entities/priority.dart';
import '../../../domain/entities/status.dart';
import '../../../domain/entities/user.dart';

class TaskFormState {
  final Status? selectedStatus;
  final Priority? selectedPriority;
  final Client? selectedClient;
  final Designer? selectedDesigner;
  final User? selectedAgency;

  final List<Status> statuses;
  final List<Priority> priorities;
  final List<Client> clients;
  final List<Designer> designers;
  final List<User> agencies;
  final bool isInitialized;

  TaskFormState({
    required this.selectedStatus,
    required this.selectedPriority,
    required this.selectedClient,
    required this.selectedDesigner,
    required this.selectedAgency,
    required this.statuses,
    required this.priorities,
    required this.clients,
    required this.designers,
    required this.agencies,
    this.isInitialized = false,
  });

  TaskFormState copyWith({
    bool? isInitialized,
    Status? selectedStatus,
    Priority? selectedPriority,
    Client? selectedClient,
    Designer? selectedDesigner,
    User? selectedAgency,
    List<Status>? statuses,
    List<Priority>? priorities,
    List<Client>? clients,
    List<Designer>? designers,
    List<User>? agencies,
  }) {
    return TaskFormState(
      isInitialized: isInitialized ?? this.isInitialized,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedClient: selectedClient ?? this.selectedClient,
      selectedDesigner: selectedDesigner ?? this.selectedDesigner,
      selectedAgency: selectedAgency ?? this.selectedAgency,
      statuses: statuses ?? this.statuses,
      priorities: priorities ?? this.priorities,
      clients: clients ?? this.clients,
      designers: designers ?? this.designers,
      agencies: agencies ?? this.agencies,
    );
  }
}
