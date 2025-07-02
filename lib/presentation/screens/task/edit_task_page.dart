import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/di.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../data/models/payloads/task_payload.dart';
import '../../../domain/entities/client.dart';
import '../../../domain/entities/designer.dart';
import '../../../domain/entities/priority.dart';
import '../../../domain/entities/status.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/user.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/enums/user_role.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/client/client_bloc.dart';
import '../../blocs/client/client_state.dart';
import '../../blocs/designer/designer_bloc.dart';
import '../../blocs/designer/designer_state.dart';
import '../../blocs/task/task_bloc.dart';
import '../../blocs/task/task_event.dart';
import '../../blocs/task/task_state.dart';
import '../../blocs/task_form/task_form_bloc.dart';
import '../../blocs/task_form/task_form_event.dart';
import '../../blocs/task_form/task_form_state.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_state.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/drop_down_menu.dart';
import '../../widgets/labeled_text_field.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({required this.task, required this.isNew, super.key});

  final Task? task;
  final bool isNew;

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late final _taskNameController = TextEditingController();
  late final _noteController = TextEditingController();
  late final _phoneController = TextEditingController();
  late final _dueDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _handleInit();
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _noteController.dispose();
    _phoneController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('Edit Task', style: AppTexts.titleTextStyle),
        actions: [
          TextButton(
            onPressed: () {
              final int? currentUserId = getIt<CacheHelper>().getUserId();
              final TaskFormState taskFormState =
                  context.read<TaskFormBloc>().state;

              final TaskPayload payload = TaskPayload(
                taskId: widget.task?.taskId,
                assignedUsers: [],
                dealNo: "dealNo",
                name: _taskNameController.text,
                startDate: DateTime.now().toString(),
                dueDate: _dueDateController.text,
                priority: taskFormState.selectedPriority?.name ?? '',
                status: taskFormState.selectedStatus?.name ?? '',
                remarks: _noteController.text,
                agencyId: taskFormState.selectedAgency?.userId,
                createdById: currentUserId ?? 0,
                clientId: taskFormState.selectedClient?.clientId ?? 0,
                designerId: taskFormState.selectedDesigner?.designerId ?? 0,
              );

              if (widget.isNew) {
                context.read<TaskBloc>().add(PutTaskRequested(payload));
              } else {
                context.read<TaskBloc>().add(UpdateTaskRequested(payload));
              }
            },
            child: Text(
              'Done',
              style: AppTexts.labelTextStyle.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is PutTaskSuccess || state is UpdateTaskSuccess) {
            context.pop();
          }
        },
        child: BlocBuilder<TaskFormBloc, TaskFormState>(
          builder: (context, state) {
            if (!state.isInitialized) {
              return const Center(child: CircularProgressIndicator());
            }

            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              behavior: HitTestBehavior.opaque,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task Details',
                      style: AppTexts.titleTextStyle.copyWith(
                        fontVariations: [FontVariation.weight(600)],
                      ),
                    ),
                    20.hGap,
                    _buildTaskFormWidgets(state, context),
                  ],
                ).padAll(AppPaddings.appPaddingInt),
              ),
            );
          },
        ),
      ),
    );
  }

  BorderedContainer _buildTaskFormWidgets(
    TaskFormState state,
    BuildContext context,
  ) {
    return BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabeledTextInput(
            title: 'Task Title',
            hint: 'Enter task title',
            controller: _taskNameController,
          ),
          if (!widget.isNew)
            _buildDropdown<Status>(
              title: 'Status',
              list: state.statuses,
              initialValue: state.selectedStatus,
              onChanged: (selected) {
                context.read<TaskFormBloc>().add(StatusChanged(selected));
              },
              labelBuilder: (s) => s.name,
              idBuilder: (s) => s.statusId?.toString() ?? '',
            ),
          _buildDropdown<Priority>(
            title: 'Priority',
            list: state.priorities,
            initialValue: state.selectedPriority,
            onChanged: (selected) {
              context.read<TaskFormBloc>().add(PriorityChanged(selected));
            },
            labelBuilder: (p) => p.name,
            idBuilder: (p) => p.priorityId?.toString() ?? '',
          ),
          LabeledTextInput(
            title: 'Due Date',
            hint: 'Enter due date',
            controller: _dueDateController,
          ),
          LabeledTextInput(
            title: 'Notes',
            hint: 'Add note',
            controller: _noteController,
            isMultiline: true,
          ),
          _buildDropdown<Client>(
            title: 'Client',
            list: state.clients,
            initialValue: state.selectedClient,
            onChanged: (selected) {
              context.read<TaskFormBloc>().add(ClientChanged(selected));
            },
            labelBuilder: (c) => c.name,
            idBuilder: (c) => c.clientId?.toString() ?? '',
          ),
          _buildDropdown<Designer>(
            title: 'Designer',
            list: state.designers,
            initialValue: state.selectedDesigner,
            onChanged: (selected) {
              context.read<TaskFormBloc>().add(DesignerChanged(selected));
            },
            labelBuilder: (d) => d.name,
            idBuilder: (d) => d.designerId?.toString() ?? '',
          ),
          if (widget.task?.agency != null || widget.isNew) ...[
            _buildDropdown<User>(
              title: 'Agency',
              list: state.agencies,
              initialValue: state.selectedAgency,
              onChanged: (selected) {
                context.read<TaskFormBloc>().add(AgencyChanged(selected));
              },
              labelBuilder: (a) => a.name,
              idBuilder: (a) => a.userId?.toString() ?? '',
            ),
          ],
        ],
      ),
    );
  }

  void _handleInit() {
    final clientState = context.read<ClientBloc>().state;
    final List<Client> customerList =
        clientState is ClientLoadSuccess ? clientState.clients : [];

    final designerState = context.read<DesignerBloc>().state;
    final List<Designer> designerList =
        designerState is DesignerLoadSuccess ? designerState.designers : [];

    final userState = context.read<UserBloc>().state;

    final List<User> userList =
        userState is UserLoadSuccess ? userState.users : [];

    final List<User> agencyList =
        userList.where((u) => u.userType == UserRole.agent).toList();

    final TaskFormBloc bloc = context.read<TaskFormBloc>();

    if (!widget.isNew) {
      _taskNameController.text = widget.task?.name ?? '';
      _noteController.text = widget.task?.remarks ?? '';
      _phoneController.text = widget.task?.client.contactNo ?? '';
      _dueDateController.text = widget.task?.dueDate.toString() ?? '';
    } else {
      _dueDateController.text =
          DateTime.now().add(const Duration(days: 2)).toString();

      bloc.add(
        ResetTaskForm(
          clients: customerList,
          designers: designerList,
          agencies: agencyList,
        ),
      );
    }
  }

  Column _buildDropdown<T>({
    required String title,
    required List<T> list,
    required ValueChanged<T> onChanged,
    T? initialValue,
    String Function(T)? labelBuilder,
    String Function(T)? idBuilder,
  }) {
    final effectiveLabelBuilder = labelBuilder ?? (value) => value.toString();
    final effectiveIdBuilder =
        idBuilder ?? (value) => value.hashCode.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.hGap,
        Text(title, style: AppTexts.labelTextStyle),
        10.hGap,
        ModelDropdownMenu<T>(
          items: list,
          initialValue: widget.isNew ? null : initialValue,
          onChanged: onChanged,
          labelBuilder: effectiveLabelBuilder,
          idBuilder: effectiveIdBuilder,
        ),
        10.hGap,
      ],
    );
  }
}
