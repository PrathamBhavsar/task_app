import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/date_formatter.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/task_form/task_form_bloc.dart';
import '../../blocs/task_form/task_form_event.dart';
import '../../blocs/task_form/task_form_state.dart';
import '../../providers/task_provider.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({required this.task, required this.isNew, super.key});

  final Task task;
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

    if (!widget.isNew) {
      _taskNameController.text = widget.task.name;
      _noteController.text = '';
      _phoneController.text = widget.task.client.contactNo;
      _dueDateController.text = widget.task.dueDate.toPrettyDate();
    } else {
      _dueDateController.text =
          DateTime.now().add(const Duration(days: 2)).toPrettyDateTime();
    }
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
    return BlocBuilder<TaskFormBloc, TaskFormState>(
      builder: (BuildContext context, TaskFormState state) {
        return Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: Text('Edit Task', style: AppTexts.titleTextStyle),
            actions: [
              TextButton(
                onPressed: () {
                  final provider = context.read<TaskProvider>();
                  // final updatedTask = Task(
                  //   name: _taskNameController.text,
                  //   client: provider.currentCustomer,
                  //   phone: _phoneController.text,
                  //   product: _productController.text,
                  //   status: provider.currentStatus,
                  //   priority: provider.currentPriority,
                  //   notes: _noteController.text,
                  //   dueDate: _dueDateController.text,
                  //   createdAt: DateTime.now().toFormattedWithSuffix(),
                  //   messages: Message.randomMessages,
                  //   bill: Bill.sampleBills.first,
                  //   address: widget.task.address,
                  // );
                  // context.pushReplacement(AppRoutes.taskDetails, extra: updatedTask);
                },
                child: Text(
                  'Done',
                  style: AppTexts.labelTextStyle.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
          body: GestureDetector(
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
                        _buildDropdown(
                          'Status',
                          state.statuses.map((s) => s.name).toList(),
                          state.selectedStatus?.name,
                          (val) {
                            final selected = state.statuses.firstWhere(
                              (s) => s.name == val,
                            );
                            context.read<TaskFormBloc>().add(
                              StatusChanged(selected),
                            );
                          },
                          widget.isNew,
                        ),
                        _buildDropdown(
                          'Priority',
                          state.priorities.map((p) => p.name).toList(),
                          state.selectedPriority?.name,
                          (val) {
                            final selected = state.priorities.firstWhere(
                              (p) => p.name == val,
                            );
                            context.read<TaskFormBloc>().add(
                              PriorityChanged(selected),
                            );
                          },
                          widget.isNew,
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
                        _buildDropdown(
                          'Client',
                          state.clients.map((c) => c.name).toList(),
                          state.selectedClient?.name,
                          (val) {
                            final selected = state.clients.firstWhere(
                              (c) => c.name == val,
                            );
                            context.read<TaskFormBloc>().add(
                              ClientChanged(selected),
                            );
                          },
                          widget.isNew,
                        ),
                        if (widget.task.agency != null && !widget.isNew) ...[
                          _buildDropdown(
                            'Agency',
                            state.agencies.map((a) => a.name).toList(),
                            state.selectedAgency?.name,
                            (val) {
                              final selected = state.agencies.firstWhere(
                                (a) => a.name == val,
                              );
                              context.read<TaskFormBloc>().add(
                                AgencyChanged(selected),
                              );
                            },
                            widget.isNew,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ).padAll(AppPaddings.appPaddingInt),
            ),
          ),
        );
      },
    );
  }

  Column _buildDropdown(
    String title,
    List<String> list,
    String? initialValue,
    Function(String) onChanged,
    bool isNew,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.hGap,
        Text(title, style: AppTexts.labelTextStyle),
        10.hGap,
        CustomDropdownMenu(
          items: list,
          initialValue: isNew ? null : initialValue,
          onChanged: onChanged,
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
