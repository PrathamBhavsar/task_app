import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/agency.dart';
import '../../../domain/entities/bill.dart';
import '../../../domain/entities/customer.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/entities/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/date_formatter.dart';
import '../../../utils/extensions/padding.dart';
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
  late final _productController = TextEditingController();
  late final _dueDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final taskProvider = context.read<TaskProvider>();

    if (!widget.isNew) {
      _taskNameController.text = widget.task.name;
      _noteController.text = widget.task.note ?? '';
      _phoneController.text = widget.task.phone;
      _productController.text = widget.task.product;
      _dueDateController.text = widget.task.dueDate;
    } else {
      taskProvider.resetFields();

      _dueDateController.text =
          DateTime.now().add(const Duration(days: 2)).toFormattedWithSuffix();
    }
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _noteController.dispose();
    _phoneController.dispose();
    _productController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Text('Edit Task', style: AppTexts.titleTextStyle),
      actions: [
        TextButton(
          onPressed: () {
            final provider = context.read<TaskProvider>();
            final updatedTask = Task(
              name: _taskNameController.text,
              customer: provider.currentCustomer,
              phone: _phoneController.text,
              product: _productController.text,
              status: provider.currentStatus,
              priority: provider.currentPriority,
              note: _noteController.text,
              dueDate: _dueDateController.text,
              createdAt: DateTime.now().toFormattedWithSuffix(),
              messages: Message.randomMessages,
              bill: Bill.sampleBills.first,
              address: widget.task.address,
            );
            context.pushReplacement(AppRoutes.taskDetails, extra: updatedTask);
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
      child: Consumer<TaskProvider>(
        builder:
            (context, provider, child) => SingleChildScrollView(
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
                          Task.statuses,
                          widget.task.status,
                          (value) => provider.setStatus(value),
                          widget.isNew,
                        ),
                        _buildDropdown(
                          'Priority',
                          ['Low', 'Medium', 'High'],
                          widget.task.priority,
                          (value) => provider.setPriority(value),
                          widget.isNew,
                        ),
                        _buildTextInput(
                          'Product',
                          'Enter product name',
                          _productController,
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
                          'Select Customer',
                          Customer.names,
                          widget.task.customer,
                          (value) => provider.setCustomer(value),
                          widget.isNew,
                        ),
                        if (widget.task.agency != null && !widget.isNew) ...[
                          _buildDropdown(
                            'Select Agency',
                            Agency.names,
                            widget.task.agency!,
                            (value) => provider.setAgency(value),
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
    ),
  );

  Column _buildDropdown(
    String title,
    List<String> list,
    String initialValue,
    Function(String) onChanged,
    bool isNew,
  ) => Column(
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

  Widget _buildTextInput(
    String title,
    String hint,
    TextEditingController controller, {
    bool isMultiline = false,
  }) => Column(
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
