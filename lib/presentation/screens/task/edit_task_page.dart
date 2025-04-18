import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/date_formatter.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/task_provider.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';
import '../agency/agency_page.dart';
import '../agency/widgets/agency_tile.dart';
import '../customer/customer_page.dart';
import '../customer/widgets/customer_tile.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.isNew) {
        _taskNameController.text = widget.task.name;
        _noteController.text = widget.task.note ?? '';
        _phoneController.text = widget.task.phone;
        _productController.text = widget.task.product;
        _dueDateController.text = widget.task.dueDate;

        final provider = context.read<TaskProvider>();

        provider.setCustomerIndex(
          customers.indexWhere(
            (customer) => customer.name == widget.task.customer,
          ),
        );
        provider.setAgencyIndex(
          agencies.indexWhere((agency) => agency.name == widget.task.agency),
        );
      }

      final provider = context.read<TaskProvider>();
      _customerPageController = PageController(
        viewportFraction: 1,
        initialPage: provider.selectedCustomerIndex,
      );
      _agencyPageController = PageController(
        viewportFraction: 1,
        initialPage: provider.selectedAgencyIndex,
      );
    });
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _noteController.dispose();
    _phoneController.dispose();
    _productController.dispose();
    _dueDateController.dispose();
    _customerPageController.dispose();
    _agencyPageController.dispose();

    final provider = context.read<TaskProvider>();
    provider.resetIndexes();
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
                        Text('Status', style: AppTexts.labelTextStyle),
                        10.hGap,
                        CustomDropdownMenu(
                          items: Task.statuses,
                          initialValue: widget.task.status,
                          onChanged: (value) => provider.setStatus(value),
                        ),
                        10.hGap,
                        Text('Priority', style: AppTexts.labelTextStyle),
                        10.hGap,
                        CustomDropdownMenu(
                          items: ['Low', 'Medium', 'High'],
                          initialValue: widget.task.priority,
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
                    'Select Customer',
                    style: AppTexts.titleTextStyle.copyWith(
                      fontVariations: [FontVariation.weight(600)],
                    ),
                  ),
                  20.hGap,
                  SizedBox(
                    height: 200.h,
                    child: PageView.builder(
                      itemCount: customers.length,
                      controller: _customerPageController,
                      itemBuilder:
                          (context, index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: GestureDetector(
                              onTap: () => provider.setCustomerIndex(index),
                              child: CustomerTile(
                                customer: customers[index],
                                isSelected:
                                    provider.selectedCustomerIndex == index,
                              ),
                            ),
                          ),
                    ),
                  ),
                  20.hGap,
                  if (widget.task.agency != null) ...[
                    Text(
                      'Agency Information',
                      style: AppTexts.titleTextStyle.copyWith(
                        fontVariations: [FontVariation.weight(600)],
                      ),
                    ),
                    20.hGap,
                    SizedBox(
                      height: 200.h,
                      child: PageView.builder(
                        itemCount: agencies.length,
                        controller: _agencyPageController,
                        itemBuilder:
                            (context, index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: GestureDetector(
                                onTap: () => provider.setAgencyIndex(index),
                                child: AgencyTile(
                                  agency: agencies[index],
                                  isSelected:
                                      provider.selectedAgencyIndex == index,
                                ),
                              ),
                            ),
                      ),
                    ),
                  ],
                  20.hGap,
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
