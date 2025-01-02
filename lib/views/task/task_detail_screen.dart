import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/overlapping_circles.dart';
import 'package:task_app/views/task/methods/show_bottom_modal.dart';
import 'package:task_app/views/task/widgets/agency_required_switch.dart';
import 'package:task_app/views/task/widgets/client_name_dropdown.dart';
import 'package:task_app/views/task/widgets/due_date_picker.dart';
import 'package:task_app/widgets/custom_tag.dart';
import 'package:task_app/widgets/custom_text_feild.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final nameController = TextEditingController();
  final assigneeController = TextEditingController();
  final nameFocusNode = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    assigneeController.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: const Text(
            'Task Details',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        body: Consumer<TaskProvider>(
          builder: (context, provider, child) {
            final data = provider.fetchedData;

            return Padding(
              padding: AppPaddings.appPadding,
              child: ListView(
                children: [
                  _buildRowWithIconAndWidget(
                    icon: Icons.person_2_rounded,
                    widget: _dropdownWidget(
                      context: context,
                      dataList: data['clients'],
                      title: 'Clients',
                      fieldName: 'name',
                      defaultText: "No Clients Yet",
                    ),
                  ),
                  AppPaddings.gapH(20),
                  CustomTextField(
                    controller: nameController,
                    focusNode: nameFocusNode,
                    labelTxt: 'Task Name',
                    hintTxt: 'Task Name',
                  ),
                  AppPaddings.gapH(20),
                  DueDatePicker(isNewTask: false),
                  _buildDivider(),
                  _buildDynamicRow(
                    context: context,
                    label: 'Status',
                    dataList: data['task_status'],
                    widget: CustomTag(
                        color: provider.stringToColor(data['task_status']
                            ?[provider.selectedIndices['status']]['color']),
                        text: data['task_status']
                                ?[provider.selectedIndices['status']]['name'] ??
                            ""),
                    field: 'status',
                  ),
                  _buildDynamicRow(
                    context: context,
                    label: 'Assigned For',
                    dataList: data['salespersons'],
                    widget: const OverlappingCircles(numberOfCircles: 3),
                    field: 'salespersons',
                  ),
                  _buildDynamicRow(
                    context: context,
                    label: 'Designers',
                    dataList: data['designers'],
                    widget: const OverlappingCircles(numberOfCircles: 3),
                    field: 'designers',
                  ),
                  _buildDynamicRow(
                    context: context,
                    label: 'Priority',
                    dataList: data['task_priority'],
                    widget: CustomTag(
                        color: provider.stringToColor(data['task_priority']
                            ?[provider.selectedIndices['priority']]['color']),
                        text: data['task_priority']
                                    ?[provider.selectedIndices['priority']]
                                ['name'] ??
                            ""),
                    field: 'priority',
                  ),
                  _buildDivider(),
                  const AgencyRequiredSwitch(),
                  if (provider.isAgencyRequired)
                    _buildDynamicRow(
                      context: context,
                      label: 'Agency',
                      dataList: data['agencies'],
                      widget: const OverlappingCircles(numberOfCircles: 3),
                      field: 'agency',
                    ),
                  _buildDivider(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Attachments', style: AppTexts.headingStyle),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRowWithIconAndWidget({
    required IconData icon,
    required Widget widget,
  }) {
    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, size: 32),
        ),
        AppPaddings.gapW(10),
        Expanded(child: widget),
      ],
    );
  }

  Widget _buildDynamicRow({
    required BuildContext context,
    required String label,
    required String field,
    required List<Map<String, dynamic>>? dataList,
    required Widget widget,
  }) {
    return Padding(
      padding: AppPaddings.appPadding,
      child: _buildRowWithTextAndWidget(
        label: label,
        widget: widget,
        onTap: () =>
            showClientsBottomSheet(context, dataList ?? [], label, field),
      ),
    );
  }

  Widget _dropdownWidget({
    required BuildContext context,
    required List<Map<String, dynamic>>? dataList,
    required String title,
    required String fieldName,
    required String defaultText,
  }) {
    return ClientNameDropdown(
      name:
          dataList?.isNotEmpty == true ? dataList![0][fieldName] : defaultText,
      clientList: dataList ?? [],
      onTap: () =>
          showClientsBottomSheet(context, dataList ?? [], title, fieldName),
    );
  }

  Widget _buildRowWithTextAndWidget({
    required String label,
    required Widget widget,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTexts.headingStyle),
            widget,
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Column(
      children: [
        AppPaddings.gapH(10),
        Divider(color: AppColors.primary),
        AppPaddings.gapH(10),
      ],
    );
  }
}
