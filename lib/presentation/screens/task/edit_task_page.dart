import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/agency.dart';
import '../../../data/models/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/date_formatter.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/task_provider.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key, required this.task, required this.isNew});

  final Task task;
  final bool isNew;

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late final _taskNameController = TextEditingController();
  late final _customerNameController = TextEditingController();
  late final _noteController = TextEditingController();
  late final _phoneController = TextEditingController();
  late final _productController = TextEditingController();
  late final _dueDateController = TextEditingController();

  @override
  void initState() {
    if (!widget.isNew) {
      _taskNameController.text = widget.task.name;
      _customerNameController.text = widget.task.customer;
      _noteController.text = widget.task.note ?? '';
      _phoneController.text = widget.task.phone;
      _productController.text = widget.task.product;
      _dueDateController.text = widget.task.dueDate;
    }
    super.initState();
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _customerNameController.dispose();
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
              customer: _customerNameController.text,
              phone: _phoneController.text,
              product: _productController.text,
              status: provider.currentStatus,
              priority: provider.currentPriority,
              note: _noteController.text,
              dueDate: _dueDateController.text,
              createdAt: DateTime.now().toFormattedWithSuffix(),
            );
            context.pushNamed('taskDetails', extra: updatedTask);
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
                        Text('Stage', style: AppTexts.labelTextStyle),
                        10.hGap,
                        CustomDropdownMenu(
                          items: [
                            'Product Selection',
                            'Measurement',
                            'Quote',
                            'Sales Order',
                            'Delivery & Payment',
                          ],
                          onChanged: (value) => provider.setStatus(value),
                        ),
                        10.hGap,
                        Text('Priority', style: AppTexts.labelTextStyle),
                        10.hGap,
                        CustomDropdownMenu(
                          items: ['Low', 'Medium', 'High'],
                          onChanged: (value) => provider.setPriority(value),
                        ),
                        10.hGap,
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
                      ],
                    ),
                  ),
                  20.hGap,
                  Text(
                    'Customer Information',
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
                          'Customer Name',
                          'Enter customer name',
                          _customerNameController,
                        ),
                        _buildTextInput(
                          'Email',
                          'Enter customer email',
                          _phoneController,
                        ),
                        _buildTextInput(
                          'Phone',
                          'Enter customer phone',
                          _phoneController,
                        ),
                      ],
                    ),
                  ),
                  20.hGap,
                  Text(
                    'Agency Information',
                    style: AppTexts.titleTextStyle.copyWith(
                      fontVariations: [FontVariation.weight(600)],
                    ),
                  ),
                  20.hGap,
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Agency', style: AppTexts.labelTextStyle),
                        10.hGap,
                        CustomDropdownMenu(items: Agency.names),
                        10.hGap,
                        _buildTextInput(
                          'Agency Phone',
                          'Enter agency phone',
                          _phoneController,
                        ),
                      ],
                    ),
                  ),
                ],
              ).padAll(AppPaddings.appPaddingInt),
            ),
      ),
    ),
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
