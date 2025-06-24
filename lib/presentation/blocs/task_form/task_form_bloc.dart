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
          selectedAgency: null,
          statuses: [],
          priorities: [],
          clients: [],
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
    on<AgencyChanged>(
      (e, emit) => emit(state.copyWith(selectedAgency: e.agency)),
    );
  }

  void _onInit(InitializeTaskForm event, Emitter<TaskFormState> emit) {
    final statuses = Status.list;
    final priorities = Priority.list;
    final customers = event.clients;
    final agencies = event.agencies;
    final task = event.existingTask;

    print(task?.status.name ?? statuses.first.name);
    print(task?.priority.name ?? priorities.first.name);
    print(task?.client.name ?? customers.first.name);
    print(task?.agency?.name ?? agencies.first.name);

    emit(
      state.copyWith(
        isInitialized: true,
        statuses: statuses,
        priorities: priorities,
        customers: customers,
        agencies: agencies,
        selectedStatus: task?.status ?? statuses.first,
        selectedPriority: task?.priority ?? priorities.first,
        selectedClient: task?.client ?? customers.first,
        selectedAgency: task?.agency ?? agencies.first,
      ),
    );
  }

  void _onReset(ResetTaskForm event, Emitter<TaskFormState> emit) {
    final statuses = Status.list;
    final priorities = Priority.list;
    final clients = event.clients;
    final agencies = event.agencies;

    emit(
      state.copyWith(
        isInitialized: true,
        statuses: statuses,
        priorities: priorities,
        customers: clients,
        agencies: agencies,
        selectedStatus: statuses.first,
        selectedPriority: priorities.first,
        selectedClient: clients.first,
        selectedAgency: agencies.first,
      ),
    );
  }
}
