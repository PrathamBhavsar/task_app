import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/client_usecase.dart';
import '../../../domain/usecases/priority_usecase.dart';
import '../../../domain/usecases/status_usecase.dart';
import '../../../domain/usecases/user_usecase.dart';
import 'task_form_event.dart';
import 'task_form_state.dart';

class TaskFormBloc extends Bloc<TaskFormEvent, TaskFormState> {
  final GetAllStatusesUseCase getAllStatuses;
  final GetAllPrioritiesUseCase getAllPriorities;
  final GetAllClientsUseCase getAllCustomers;
  final GetAllUsersUseCase getAllAgencies;

  TaskFormBloc({
    required this.getAllStatuses,
    required this.getAllPriorities,
    required this.getAllCustomers,
    required this.getAllAgencies,
  }) : super(
    TaskFormState(
      selectedStatus: null,
      selectedPriority: null,
      selectedCustomer: null,
      selectedAgency: null,
      statuses: [],
      priorities: [],
      customers: [],
      agencies: [],
    ),
  ) {
    on<InitializeTaskForm>(_onInit);
    on<StatusChanged>((e, emit) => emit(state.copyWith(selectedStatus: e.status)));
    on<PriorityChanged>((e, emit) => emit(state.copyWith(selectedPriority: e.priority)));
    on<CustomerChanged>((e, emit) => emit(state.copyWith(selectedCustomer: e.customer)));
    on<AgencyChanged>((e, emit) => emit(state.copyWith(selectedAgency: e.agency)));
  }

  Future<void> _onInit(InitializeTaskForm event, Emitter<TaskFormState> emit) async {
    final statuses = await getAllStatuses();
    final priorities = await getAllPriorities();
    final customers = await getAllCustomers();
    final agencies = await getAllAgencies();

    final task = event.existingTask;

    // emit(state.copyWith(
    //   statuses: statuses,
    //   priorities: priorities,
    //   customers: customers,
    //   agencies: agencies,
    //   selectedStatus: task?.status ?? statuses.first,
    //   selectedPriority: task?.priority ?? priorities.first,
    //   selectedCustomer: task?.client ?? customers.first,
    //   selectedAgency: task?.agency ?? (agencies.isNotEmpty ? agencies.first : null),
    // ));
  }
}
