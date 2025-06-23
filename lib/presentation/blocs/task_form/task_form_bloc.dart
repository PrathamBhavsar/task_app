import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/client.dart';
import '../../../domain/entities/priority.dart';
import '../../../domain/entities/status.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/client_usecase.dart';
import '../../../domain/usecases/priority_usecase.dart';
import '../../../domain/usecases/status_usecase.dart';
import '../../../domain/usecases/user_usecase.dart';
import '../../../utils/enums/status_type.dart';
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
    on<StatusChanged>(
      (e, emit) => emit(state.copyWith(selectedStatus: e.status)),
    );
    on<PriorityChanged>(
      (e, emit) => emit(state.copyWith(selectedPriority: e.priority)),
    );
    on<ClientChanged>(
      (e, emit) => emit(state.copyWith(selectedCustomer: e.customer)),
    );
    on<AgencyChanged>(
      (e, emit) => emit(state.copyWith(selectedAgency: e.agency)),
    );
  }

  Future<void> _onInit(
    InitializeTaskForm event,
    Emitter<TaskFormState> emit,
  ) async {
    final customerResult = await getAllCustomers();
    final agencyResult = await getAllAgencies();

    final statuses = Status.list;
    final priorities = Priority.list;
    final customers = customerResult.fold((l) => <Client>[], (r) => r);
    final agencies = agencyResult.fold((l) => <User>[], (r) => r);

    final task = event.existingTask;

    emit(
      state.copyWith(
        statuses: statuses,
        priorities: priorities,
        customers: customers,
        agencies: agencies,
        selectedStatus: task?.status ?? (statuses.first),
        selectedPriority:
            task?.priority ?? (priorities.isNotEmpty ? priorities.first : null),
        selectedCustomer:
            task?.client ?? (customers.isNotEmpty ? customers.first : null),
        selectedAgency:
            task?.agency ?? (agencies.isNotEmpty ? agencies.first : null),
      ),
    );
  }
}
