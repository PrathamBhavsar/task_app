import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/priority.dart';
import '../../../domain/entities/status.dart';
import '../../../domain/usecases/client_usecase.dart';
import '../../../domain/usecases/user_usecase.dart';
import 'task_form_event.dart';
import 'task_form_state.dart';

class TaskFormBloc extends Bloc<TaskFormEvent, TaskFormState> {
  final GetAllClientsUseCase getAllCustomers;
  final GetAllUsersUseCase getAllAgencies;

  TaskFormBloc({required this.getAllCustomers, required this.getAllAgencies})
    : super(
        TaskFormState(
          selectedStatus: null,
          selectedPriority: null,
          selectedClient: null,
          selectedDesigner: null,
          selectedAgency: null,
          statuses: [],
          priorities: [],
          clients: [],
          designers: [],
          agencies: [],
        ),
      ) {
    on<InitializeTaskForm>(_onInit);
    on<ResetTaskForm>(_onReset);
    on<StatusChanged>(
      (e, emit) => emit(state.copyWith(selectedStatus: e.status)),
    );
    on<PriorityChanged>(
      (e, emit) => emit(state.copyWith(selectedPriority: e.priority)),
    );
    on<ClientChanged>(
      (e, emit) => emit(state.copyWith(selectedClient: e.client)),
    );
    on<DesignerChanged>(
      (e, emit) => emit(state.copyWith(selectedDesigner: e.designer)),
    );
    on<AgencyChanged>(
      (e, emit) => emit(state.copyWith(selectedAgency: e.agency)),
    );
  }

  void _onInit(InitializeTaskForm event, Emitter<TaskFormState> emit) {
    final statuses = Status.list;
    final priorities = Priority.list;
    final clients = event.clients;
    final designers = event.designers;
    final agencies = event.agencies;
    final task = event.existingTask;

    print(task?.status.name ?? statuses.first.name);
    print(task?.priority.name ?? priorities.first.name);
    print(task?.client.name ?? clients.first.name);
    print(task?.designer.name ?? designers.first.name);
    print(task?.agency?.name ?? agencies.first.name);

    emit(
      state.copyWith(
        isInitialized: true,
        statuses: statuses,
        priorities: priorities,
        clients: clients,
        designers: designers,
        agencies: agencies,
        selectedStatus: task?.status ?? statuses.first,
        selectedPriority: task?.priority ?? priorities.first,
        selectedClient: task?.client ?? clients.first,
        selectedDesigner: task?.designer ?? designers.first,
        selectedAgency: task?.agency ?? agencies.first,
      ),
    );
  }

  void _onReset(ResetTaskForm event, Emitter<TaskFormState> emit) {
    final statuses = Status.list;
    final priorities = Priority.list;
    final clients = event.clients;
    final designers = event.designers;
    final agencies = event.agencies;

    emit(
      state.copyWith(
        isInitialized: true,
        statuses: statuses,
        priorities: priorities,
        clients: clients,
        designers: designers,
        agencies: agencies,
        selectedStatus: statuses.first,
        selectedPriority: priorities.first,
        selectedClient: clients.first,
        selectedDesigner: designers.first,
        selectedAgency: agencies.first,
      ),
    );
  }
}
