import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/agency.dart';
import '../../../data/models/bill.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/message.dart';
import '../../../data/models/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/date_formatter.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/task_provider.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';
import '../agency/agency_page.dart';
import '../customer/customer_page.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key, required this.task, required this.isNew});

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

  late PageController _customerPageController;
  late PageController _agencyPageController;

  @override
  void initState() {
    super.initState();

    if (!widget.isNew) {
      final customerIndex = customers.indexWhere(
        (customer) => customer.name == widget.task.customer,
      );
      final agencyIndex = agencies.indexWhere(
        (agency) => agency.name == widget.task.agency,
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<TaskProvider>().setCustomerIndex(customerIndex);
        context.read<TaskProvider>().setAgencyIndex(agencyIndex);
      });
      _taskNameController.text = widget.task.name;
      _noteController.text = widget.task.note ?? '';
      _phoneController.text = widget.task.phone;
      _productController.text = widget.task.product;
      _dueDateController.text = widget.task.dueDate;
    }

    _customerPageController = PageController(
      viewportFraction: 1,
      initialPage: context.read<TaskProvider>().selectedCustomerIndex,
    );

    _agencyPageController = PageController(
      viewportFraction: 1,
      initialPage: context.read<TaskProvider>().selectedAgencyIndex,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().resetIndexes();
    });
    _taskNameController.dispose();
    _noteController.dispose();
    _phoneController.dispose();
    _productController.dispose();
    _dueDateController.dispose();
    _customerPageController.dispose();
    _agencyPageController.dispose();
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
              customer: customers[provider.selectedCustomerIndex].name,
              agency: agencies[provider.selectedAgencyIndex].name,
              phone: _phoneController.text,
              product: _productController.text,
              status: provider.currentStatus,
              priority: provider.currentPriority,
              note: _noteController.text,
              dueDate: _dueDateController.text,
              createdAt: DateTime.now().toFormattedWithSuffix(),
              messages: Message.randomMessages,
              bill: Bill.sampleBills.first,
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
                        _buildDropdown(
                          'Status',
                          Task.statuses,
                          widget.task.status,
                          (value) => provider.setStatus(value),
                        ),
                        _buildDropdown(
                          'Priority',
                          ['Low', 'Medium', 'High'],
                          widget.task.priority,
                          (value) => provider.setPriority(value),
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
                        ),

                        if (widget.task.agency != null) ...[
                          _buildDropdown(
                            'Select Agency',
                            Agency.names,
                            widget.task.agency!,
                            (value) => provider.setAgency(value),
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
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      10.hGap,
      Text(title, style: AppTexts.labelTextStyle),
      10.hGap,
      CustomDropdownMenu(
        items: list,
        initialValue: initialValue,
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
