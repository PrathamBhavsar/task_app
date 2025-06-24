import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/client.dart';
import '../../../domain/entities/priority.dart';
import '../../../domain/entities/status.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/user.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/enums/user_role.dart';
import '../../../utils/extensions/date_formatter.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/client/client_bloc.dart';
import '../../blocs/client/client_state.dart';
import '../../blocs/task_form/task_form_bloc.dart';
import '../../blocs/task_form/task_form_event.dart';
import '../../blocs/task_form/task_form_state.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_state.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';

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
            onPressed: () {},
            child: Text(
              'Done',
              style: AppTexts.labelTextStyle.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TaskFormBloc, TaskFormState>(
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
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextInput(
                          'Task Title',
                          'Enter task title',
                          _taskNameController,
                        ),
                        _buildDropdown<Status>(
                          title: 'Status',
                          list: state.statuses,
                          initialValue: state.selectedStatus,
                          onChanged: (selected) {
                            context.read<TaskFormBloc>().add(
                              StatusChanged(selected),
                            );
                          },
                          labelBuilder: (s) => s.name,
                          idBuilder: (s) => s.statusId?.toString() ?? '',
                        ),
                        _buildDropdown<Priority>(
                          title: 'Priority',
                          list: state.priorities,
                          initialValue: state.selectedPriority,
                          onChanged: (selected) {
                            context.read<TaskFormBloc>().add(
                              PriorityChanged(selected),
                            );
                          },
                          labelBuilder: (p) => p.name,
                          idBuilder: (p) => p.priorityId?.toString() ?? '',
                        ),
                        _buildTextInput(
                          'Due Date',
                          'Enter due date',
                          _dueDateController,
                        ),
                        _buildTextInput(
                          'Notes',
                          'Add note',
                          _noteController,
                          isMultiline: true,
                        ),
                        _buildDropdown<Client>(
                          title: 'Client',
                          list: state.clients,
                          initialValue: state.selectedClient,
                          onChanged: (selected) {
                            context.read<TaskFormBloc>().add(
                              ClientChanged(selected),
                            );
                          },
                          labelBuilder: (c) => c.name,
                          idBuilder: (c) => c.clientId?.toString() ?? '',
                        ),
                        if (widget.task?.agency != null && !widget.isNew) ...[
                          _buildDropdown<User>(
                            title: 'Agency',
                            list: state.agencies,
                            initialValue: state.selectedAgency,
                            onChanged: (selected) {
                              context.read<TaskFormBloc>().add(
                                AgencyChanged(selected),
                              );
                            },
                            labelBuilder: (a) => a.name,
                            idBuilder: (a) => a.userId?.toString() ?? '',
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ).padAll(AppPaddings.appPaddingInt),
            ),
          );
        },
      ),
    );
  }

  void _handleInit() {
    final clientState = context.read<ClientBloc>().state;
    final List<Client> customerList =
        clientState is ClientLoadSuccess ? clientState.clients : [];

    final agencyState = context.read<UserBloc>().state;
    final List<User> agencyList =
        agencyState is UserLoadSuccess
            ? agencyState.users
                .where((u) => u.userType == UserRole.agent)
                .toList()
            : [];

    final TaskFormBloc bloc = context.read<TaskFormBloc>();

    if (!widget.isNew) {
      bloc.add(
        InitializeTaskForm(
          existingTask: widget.task,
          clients: customerList,
          agencies: agencyList,
        ),
      );

      _taskNameController.text = widget.task?.name ?? '';
      _noteController.text = widget.task?.remarks ?? '';
      _phoneController.text = widget.task?.client.contactNo ?? '';
      _dueDateController.text = widget.task?.dueDate.toPrettyDate() ?? '';
    } else {
      _dueDateController.text =
          DateTime.now().add(const Duration(days: 2)).toPrettyDateTime();

      bloc.add(ResetTaskForm(clients: customerList, agencies: agencyList));
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

  Widget _buildTextInput(
    String title,
    String hint,
    TextEditingController controller, {
    bool isMultiline = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTexts.labelTextStyle),
        10.hGap,
        CustomTextField(
          hintTxt: hint,
          isMultiline: isMultiline,
          controller: controller,
        ),
        10.hGap,
      ],
    );
  }
}
